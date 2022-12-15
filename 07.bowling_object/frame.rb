# frozen_string_literal: true

require './shot'

class Frame
  def initialize(first_mark, second_mark = nil, third_mark = nil)
    @first_shot  = Shot.new(first_mark).score
    @second_shot = Shot.new(second_mark).score
    @third_shot  = Shot.new(third_mark).score
  end

  def score
    if @third_shot != 0
      @first_shot + @second_shot + @third_shot
    else
      @first_shot + @second_shot
    end
  end
end
