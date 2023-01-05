# frozen_string_literal: true

require 'pry'

def find_dir
  array = []
  Dir.glob('*') { |item| array << item }
  array
end

def adjust_dir
  dir_slice = find_dir.size / 4
  dir = if find_dir.size % dir_slice < dir_slice
          # 要素数を割って余りが出た場合の条件
          find_dir.sort.each_slice(dir_slice + 1).to_a
        else
          find_dir.sort.each_slice(dir_slice).to_a
        end
  max = dir.max_by(&:size).size
  dir.each do |a|
    a << nil while a.size < max
  end
end

def trans_dir
  trans_dir = adjust_dir.transpose.flatten
  trans_dir.each_with_index do |item, index|
    print ' ' if item.nil?
    print ((index + 1) % 4).zero? ? "#{item}\n" : item.ljust(24)
  end
end

trans_dir
