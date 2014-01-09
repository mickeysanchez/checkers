class Piece
  attr_reader :color

  def initialize(color = :white)
    @color = color
    @king = false
  end

  def slide(to)
  end

  def jump(to)
  end

  def move_diffs
  end
end