class Board
  BOARD_SIZE = 10

  def initialize
    @rows = Array.new(BOARD_SIZE) {Array.new(BOARD_SIZE)}
    populate_rows
  end

  def [](pos)
    raise "invalid pos" unless valid?(pos)
    i, j = pos
    @rows[i][j]
  end

  private

  def populate_rows
    # sets up initial game state
  end

  def valid?(pos)
    y, x = pos
    y < BOARD_SIZE && y >= 0 && x < BOARD_SIZE && x >= 0
  end
end