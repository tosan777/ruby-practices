# frozen_string_literal: true

require 'pry'
require 'optparse'
require 'etc'

def optparse
  opt = OptionParser.new
  params = {}
  opt.on('-a') { |v| params[:a] = v }
  opt.on('-r') { |v| params[:r] = v }
  opt.on('-l') { |v| params[:l] = v }
  opt.parse(ARGV)
  params
end

# タイムスタンプを返す
def get_last_time(file_stat)
  if Time.now - file_stat.mtime >= (60 * 60 * 24 * (365 / 2.0)) || (Time.now - file_stat.mtime).negative?
    file_stat.mtime.strftime('%_m %_d  %Y')
  else
    file_stat.mtime.strftime('%_m %_d %H:%M')
  end
end

# ファイルタイプを変換
def ftype_generate(ftype)
  {
    'fifo' => 'p',
    'characterSpecial' => 'c',
    'directory' => 'd',
    'blockSpecial' => 'b',
    'file' => '-',
    'link' => 'l',
    'socket' => 's'
  }[ftype]
end

# 8進数のパーミッションを文字列に変換
def mode_generate(mode)
  mode_generates = mode.slice(-3, 3).each_char.map do |char|
    {
      '0' => '---',
      '1' => '--x',
      '2' => '-w-',
      '3' => '-wx',
      '4' => 'r--',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }[char]
  end
  special_permission_generate(mode, mode_generates)
  mode_generates.join
end

# 2進数を返す
def binary_number_format(mode)
  binary_number = mode.slice(-4).to_i.to_s(2)
  binary_number_format = format("%03d", binary_number)
end

# 特別権限が付与されていた場合のパーミッションの変換
def special_permission_generate(mode, mode_generates)
  number_split = binary_number_format(mode).split('')
  number_split.each_with_index do |char, i|
    if char == '1'
      replace = mode_generates[i].slice(2) == 'x' ? 's' : 'S'
      if i == 2
        replace = replace.include?('s') ? 't' : 'T'
      end
      mode_generates[i] = mode_generates[i].gsub(/.$/, replace)
    end
  end
end

def file_stats_conversion(file_stat, file)
  {
    ftype_permission: ftype_generate(file_stat.ftype),
    file_mode: mode_generate(file_stat.mode.to_s(8)),
    stat_nlink: file_stat.nlink,
    stat_uid: Etc.getpwuid(file_stat.uid).name,
    stat_gid: Etc.getgrgid(file_stat.gid).name,
    stat_size: file_stat.size.to_s.rjust(5),
    stat_time: get_last_time(file_stat),
    file_name: file
  }
end

def display_file
  find_dir = Dir.glob('*', optparse[:a] ? File::FNM_DOTMATCH : 0)
  find_sort_dir = find_dir.sort
  finalize_dir = optparse[:r] ? find_sort_dir.reverse : find_sort_dir

  if optparse[:l]
    display_stat_files(finalize_dir)
  else
    display_files(finalize_dir)
  end
end

def display_stat_files(find_sort_dir)
  file_stats = find_sort_dir.map do |file|
    file_stat = File.stat(file)
    file_stats_conversion(file_stat, file)
  end

  file_stats.each do |file|
    print file[:ftype_permission].to_s
    print file[:file_mode].to_s.ljust(11)
    print "#{file[:stat_nlink]} "
    print "#{file[:stat_uid]}  "
    print "#{file[:stat_gid]} "
    print file[:stat_size].to_s.ljust(6)
    print "#{file[:stat_time]} "
    print "#{file[:file_name]}\n"
  end
end

def display_files(find_sort_dir)
  slice_dir = slice_directory(find_sort_dir)
  adjust_dir = adjust_directory(slice_dir)
  trans_dir = adjust_dir.transpose
  trans_dir.each do |trans_dir_item|
    adjust_dir_item = trans_dir_item.map { |item| item.ljust(24) }.join
    print "#{adjust_dir_item}\n"
  end
end

COLUMN = 3

def slice_directory(find_sort_dir)
  dir_division = find_sort_dir.size / COLUMN
  dir_division += 1 unless (find_sort_dir.size % COLUMN).zero?
  slice_dir = find_sort_dir.each_slice(dir_division).to_a
end

def adjust_directory(slice_dir)
  max = slice_dir.max_by(&:size).size
  adjust_dir = slice_dir.each { |a| a << '' while a.size < max }
end

display_file
