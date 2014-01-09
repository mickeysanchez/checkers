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
    @rows.each_with_index do |row, y|
      rows.each_with_index do |spot,x|
        @rows[y][x] = Piece.new if x % 2 == 0
      end
    end
  end

  def valid?(pos)
    y, x = pos
    y < BOARD_SIZE && y >= 0 && x < BOARD_SIZE && x >= 0
  end
end