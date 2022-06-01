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
  if frame[0] == 10 && frames[index + 1].first == 10
    point += frame[0] + frames[index + 1].first + frames[index + 2].first
    break if index == 9
  elsif frame[0] == 10
    point += 10 + frames[index + 1].sum
    break if index == 9
  elsif frame.sum == 10
    point += frame.sum + frames[index + 1].first
    break if index == 9
  else
    point += frame.sum
  end
end
puts point
