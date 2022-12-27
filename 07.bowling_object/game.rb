# frozen_string_literal: true

require './frame'

class Game
  def initialize(frames)
    @frames = frames.split(',')
  end

  def frames
    frames = []
    @frames.each do |item|
      item == 'X' ? frames << item << 0 : frames << item
    end

    frames.each_slice(2).to_a
  end

  def score
    score = 0
    frames.each_with_index do |frame, index|
      return score if index == 10
      frame = Frame.new(frame[0], frame[1])

      score += if frame.strike? && Frame.new(frames[index + 1].first).strike?
                frame.score + Frame.new(frames[index + 1].first, frames[index + 2].first).score
              elsif frame.strike?
                frame.score + Frame.new(frames[index + 1].first, frames[index + 1].last).score
              elsif frame.spare?
                frame.score + Frame.new(frames[index + 1].first).score
              else
                frame.score
              end
    end
    score
  end
end

score = ARGV[0]
game = Game.new(score)
p game.score
