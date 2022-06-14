#!/usr/bin/env ruby

array = []

Dir.foreach('.') do |item|
  next if item == '.' or item == '..'
  array << item
end

binding.irb

array.each_with_index do |item, index|
  puts "\n" if index % 3 == 0
  print item.ljust(25)
end
