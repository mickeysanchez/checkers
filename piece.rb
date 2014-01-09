class Piece
  attr_reader :color, :icon

  def initialize(color = :white)
    @color = color
    @king = false
    @icon = (@color == :white) ? "\u25CB" : "\u25CF"
  end

  def slide(to, board)
    boar
  end

  def jump(to, board)
  end

  def move_diffs
    if @color == :white && @king == false
      [[-1, 1],[-1, 1]]
    elsif @color == :black && @king == false
      [[1, 1], [1, 1]]
    else
      [[-1, 1], [-1, 1], [1, 1], [1, 1]]
    end
  end
end