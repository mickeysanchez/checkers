class Piece
  attr_reader :color, :icon, :current_pos

  def initialize(color, pos)
    @color = color
    @current_pos = pos
    @king = false
    @icon = (@color == :white) ? "\u25CB" : "\u25CF"
  end

  def slide_to(y, x)
    diff = [y - @current_pos[0], x - @current_pos[1]]

    raise "I, a piece, cannot slide in such a way!" unless    slide_diffs.include?(diff)

    @current_pos = [y, x]
  end

  def jump_to(y, x)
    @current_pos = [y, x]
  end


  private

    def slide_diffs
      # white always starts on bottom
      # hence, it can only move up
      if @color == :white && @king == false
        [[-1, -1],[-1, 1]]
      elsif @color == :black && @king == false
        [[1, 1], [1, -1]]
      else
        [[-1, 1], [-1, 1], [1, 1], [1, 1]]
      end
    end
end
