# frozen_string_literal: true
 
require 'rubygems'
require 'bundler/setup'
require 'debug'

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end


point = 0
frames.each_with_index do |frame, index|
 if frames[index].sum == 10 && frames[index + 1].sum == 10
   point += frames[index].sum + frames[index + 1].sum + frames[index + 2].first
 elsif frame[0] == 10
   point += 10 + (frames[index + 1].sum)
 elsif frame.sum == 10 
   point += frame.sum + (frames[index + 1].first)
 else
   point += frame.sum
 end

 if frames[index] == 9 && frames[index].first == 10
   point += (frames[index] >> frames[index + 1]).sum
 elsif frames[index] == 9 && frames[index].sum == 10
   point += (frames[index] >> frames[index + 1]).sum
 else
   ""
 end 
end
puts point
