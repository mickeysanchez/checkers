class Piece
  attr_reader :color, :icon, :current_pos

  def initialize(color, pos)
    @color = color
    @current_pos = pos
    @king = false
    @icon = (@color == :white) ? "\u25CB" : "\u25CF"
  end

  def slide(to)
  end

  def jump(to)
  end

  def move_diffs
    # white always starts on bottom
    # hence, it can only move up
    if @color == :white && @king == false
      [[-1, 1],[-1, 1]]
    elsif @color == :black && @king == false
      [[1, 1], [1, 1]]
    else
      [[-1, 1], [-1, 1], [1, 1], [1, 1]]
    end
  end
end