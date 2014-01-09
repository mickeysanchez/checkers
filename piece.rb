class Piece
  attr_reader :color, :icon

  def initialize(color = :white)
    @color = color
    @king = false
    @icon = (@color == :white) ? "\u25CB" : "\u25CF"
  end

  def slide(to)
  end

  def jump(to)
  end

  def move_diffs
  end
end