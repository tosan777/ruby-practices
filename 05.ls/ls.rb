#!/usr/bin/env ruby
require 'pry'

def find_dir
  array = []
  Dir.foreach('.') do |item|
    next if item.match(/\A\.+/)
    array << item
  end
  array
end

def show_dir
  dir = find_dir.sort.each_slice(3).to_a
  max = dir.max_by { |a| a.size }.size
  adjust_dir = dir.each do |a|
              while a.size < max
                a << nil
              end
            end
  trans_dir = adjust_dir.transpose.flatten
  trans_dir.each_with_index do |item, index|
    next if item == nil
    print (index + 1) % 3 == 0 ? "#{item}\n" : item.ljust(24)
  end
end

show_dir
