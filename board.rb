require 'colorize'

class Board
  BOARD_SIZE = 10

  def initialize
    @rows = Array.new(BOARD_SIZE) {Array.new(BOARD_SIZE) {nil}}
    populate_rows
  end

  def [](pos)
    raise "invalid pos" unless valid?(pos)
    i, j = pos
    @rows[i][j]
  end

  def display
    puts
    @rows.each_with_index do |row, y|
      row.each_with_index do |spot, x|

        show = (spot.nil?) ? "   " : " #{spot.icon} "

        if y.even? && x.even? || y.odd? && x.odd?
          print show.colorize(background: :red)
        else
          print show
        end

      end
      puts
    end
    puts
  end

  private

  def populate_rows
    # could refactor this using board size if i wanted to have
    # some weird big chess game.

    @rows.each_with_index do |row, y|
      next if y > 3 && y < 6
      row.each_index do |x|
        if x.odd? && y.even? && y < 4
          @rows[y][x] = Piece.new(:black)
        elsif x.even? && y.odd? && y < 4
          @rows[y][x] = Piece.new(:black)
        elsif x.odd? && y.even? && y > 5
          @rows[y][x] = Piece.new
        elsif x.even? && y.odd? && y > 5
          @rows[y][x] = Piece.new
        end
      end
    end
  end

  def valid?(pos)
    y, x = pos
    y < BOARD_SIZE && y >= 0 && x < BOARD_SIZE && x >= 0
  end
end