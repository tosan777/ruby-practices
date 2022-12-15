# frozen_string_literal: true

require './frame'

class Game
  def initialize(frame)
    @frame = frame.split(',')
  end

  def frames
    frame = []
    @frame.each do |item|
      item == 'X' ? frame << item << 0 : frame << item
    end

    frame.each_slice(2).to_a
  end

  def score
    score = 0
    frames.each_with_index do |frame, index|
      return score if index == 10
      if frame.first == 'X' && frames[index + 1].first == 'X'
        score += Frame.new(frame.first, frames[index + 1].first, frames[index + 2].first).score
      elsif frame.first == 'X'
        score += Frame.new(frame.first, frames[index + 1].first, frames[index + 1].last).score
      elsif frame.first.to_i + frame.last.to_i == 10
        score += Frame.new(frame.first, frame.last, frames[index + 1].first).score
      else
        score += Frame.new(frame.first, frame.last).score
      end
    end
    score
  end
end

score = ARGV[0]
game = Game.new(score)
p game.score
