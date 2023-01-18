# frozen_string_literal: true

require 'pry'

def find_dir
  Dir.glob('*')
end

COLUMN = 3

def slice_dir
  dir_division = find_dir.size / COLUMN
  dir_slice = (find_dir.size % COLUMN).zero? ? dir_division : dir_division + 1
  slice_dir = find_dir.each_slice(dir_slice).to_a
end

def adjust_dir
  max = slice_dir.max_by(&:size).size
  slice_dir.each { |a| a << '' while a.size < max }
end

def trans_dir
  trans_dir = adjust_dir.transpose
  trans_dir.each do |trans_dir_item|
    adjust_dir_item = trans_dir_item.map { |item| item.ljust(24) }.join
    print "#{adjust_dir_item}\n"
  end
end

trans_dir
