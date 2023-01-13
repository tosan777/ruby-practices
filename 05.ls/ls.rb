# frozen_string_literal: true

require 'pry'

def find_dir
  array = []
  Dir.glob('*') { |item| array << item }
  array
end

COLUMN = 3

def slice_dir
  dir_slice = find_dir.size / COLUMN
  sort_dir = find_dir.sort
  if (sort_dir.size % COLUMN).zero?
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
