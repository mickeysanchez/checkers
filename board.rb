require 'colorize'

class Board
  attr_reader :pieces

  BOARD_SIZE = 10

  def initialize
    @rows = Array.new(BOARD_SIZE) {Array.new(BOARD_SIZE) {nil}}
    @pieces = []
    create_pieces
    populate_rows
  end

  def [](pos)
    raise "pos not on board" unless on_board?(pos)
    i, j = pos
    @rows[i][j]
  end

  def display
    puts
    print "   0  1  2  3  4  5  6  7  8  9"
    puts
    @rows.each_with_index do |row, y|
      print y.to_s + " "

      row.each_with_index do |spot, x|

        show = (spot.nil?) ? "   " : " #{spot.icon} "

        if y.even? && x.even? || y.odd? && x.odd?
          print show.colorize(background: :red)
        else
          print show
        end
      end
      print " " + y.to_s
      puts
    end
    print "   0  1  2  3  4  5  6  7  8  9"
    puts
    puts
  end

  def update
    de_populate_rows
    populate_rows
  end

  def make_move(move)
    from, to = move

    raise "Your first position is invalid." unless on_board?(to)
    raise "Your second position is invalid." unless on_board?(from)

    y,x = from
    piece = @rows[y][x]

    y,x = to
    piece.slide_to(y,x)
  end


  private

  def populate_rows
    de_populate_rows
    @pieces.each do |piece|
      y, x = piece.current_pos
      @rows[y][x] = piece
    end
  end

  def create_pieces
    0.upto(BOARD_SIZE-1) do |y|
      next if y > 3 && y < BOARD_SIZE - 4

      0.upto(BOARD_SIZE-1) do |x|
        if x.odd? && y.even? && y < 4
          piece = Piece.new(:black, [y,x])
        elsif x.even? && y.odd? && y < 4
          piece = Piece.new(:black, [y,x])
        elsif x.odd? && y.even? && y > 5
          piece = Piece.new(:white, [y,x])
        elsif x.even? && y.odd? && y > 5
          piece = Piece.new(:white, [y,x])
        end

        @pieces << piece unless piece == nil
      end
    end
  end

  def de_populate_rows
    @rows.each_with_index do |row, y|
      row.each_index do |x|
        @rows[y][x] = nil
      end
    end
  end

  def on_board?(pos)
    y, x = pos
    y <= BOARD_SIZE-1 && y >= 0 && x <= BOARD_SIZE-1 && x >= 0
  end
end