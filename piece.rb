class Piece
  attr_reader :color, :icon
  attr_accessor :current_pos, :king

  def initialize(color, pos)
    @color = color
    @current_pos = pos
    @king = false
    @icon = (@color == :white) ? "\u25CB" : "\u25CF"
  end

  def slide_to(y, x)
    @current_pos = [y, x]
  end

  def jump_to(y, x)
    @current_pos = [y, x]
  end

  def possible_slide?(y, x)
    diff = [y - @current_pos[0], x - @current_pos[1]]
    slide_diffs.include?(diff)
  end

  private

  def slide_diffs
      # white always starts on bottom hence it can only move up.
      if @color == :white && @king == false
        [[-1, -1],[-1, 1]]
      elsif @color == :black && @king == false
        [[1, 1], [1, -1]]
      else
        [[-1, 1], [-1, -1], [1, 1], [1, -1]]
      end
  end
end
