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

point = frames.each_with_index.sum do |frame, index|
  next 0 if index >= 10
  if frame[0] == 10 && frames[index + 1].first == 10
    frame[0] + frames[index + 1].first + frames[index + 2].first
  elsif frame[0] == 10
    10 + frames[index + 1].sum
  elsif frame.sum == 10
    frame.sum + frames[index + 1].first
  else
    frame.sum
  end
end
puts point
