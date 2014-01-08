class Board
  BOARD_SIZE = 10

  def initialize
    @rows = Array.new(BOARD_SIZE) {Array.new(BOARD_SIZE)}
  end

  def [](pos)
    i, j = pos
    @rows[i][j]
  end
end