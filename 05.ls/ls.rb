# frozen_string_literal: true

require 'pry'

def find_dir
  array = []
  Dir.glob('*') { |item| array << item }
  array
end

def slice_dir
  column = 3
  dir_slice = find_dir.size / column
  sort_dir = find_dir.sort
  if (sort_dir.size % column).zero?
    sort_dir.each_slice(dir_slice).to_a
  else
    sort_dir.each_slice(dir_slice + 1).to_a
  end
end

def adjust_dir
  max = slice_dir.max_by(&:size).size
  slice_dir.each { |a| a << '' while a.size < max }
end

def trans_dir
  trans_dir = adjust_dir.transpose
  trans_dir.each do |array|
    adjust_array = array.map { |item| item.ljust(24) }.join
    print "#{adjust_array}\n"
  end
end

trans_dir
