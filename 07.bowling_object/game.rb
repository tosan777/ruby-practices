# frozen_string_literal: true

require './frame'

class Game

  def initialize(frames)
    @frames = frames.split(',')
  end

  def adjust_frame
    adjust_frame = []
    @frames.each do |item|
      item == 'X' ? adjust_frame << item << 0 : adjust_frame << item
    end
    adjust_frame.each_slice(2).to_a
  end

  def frames
    frames = []
    adjust_frame.each do |item|
      item[1] = 0 if item[1].nil?
      frames << Frame.new(item[0],item[1])
    end
    frames
  end

  def score
    score = 0
    frames.each_with_index do |frame, index|
      return score if index == 10

      score += if frame.strike? && frames[index + 1].strike?
                frame.score + frames[index + 1].first_shot.score + frames[index + 2].first_shot.score
              elsif frame.strike?
                frame.score + frames[index + 1].score
              elsif frame.spare?
                frame.score + frames[index + 1].first_shot.score
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
