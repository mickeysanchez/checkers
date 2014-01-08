class Board
  BOARD_SIZE = 10

  def initialize
    @array = Array.new(BOARD_SIZE) {Array.new(BOARD_SIZE)}
  end
end