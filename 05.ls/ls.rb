# frozen_string_literal: true

require 'pry'

def find_dir
  array = []
  Dir.foreach('.') do |item|
    next if /\A\.+/.match?(item)

    array << item
  end
  array
end

def adjust_dir
  dir = if find_dir.size % 4 == 3 || find_dir.size % 4 == 2
          find_dir.sort.each_slice(4).to_a
        else
          find_dir.sort.each_slice(3).to_a
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
    print ((index + 1) % 3).zero? ? "#{item}\n" : item.ljust(24)
  end
end

trans_dir
