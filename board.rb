require 'colorize'

class Board
  attr_accessor :pieces

  BOARD_SIZE = 10
	#REV: Don't create an array of pieces, you can just do the @rows.flatten.compact
	#it leads to problems in the future because you need to maintain 2 things that have basically the same info in them (@rows and @pieces)
  def initialize
    @rows = Array.new(BOARD_SIZE) {Array.new(BOARD_SIZE) {nil}}
    @pieces = []
    create_pieces
    populate_rows
  end
   #REV: use the setter for this as well, very useful
   #it's something like:
   #def []=(pos, value)
   #i,j=pos
   #@rows[i][j]=value   end
  def [](pos)
    raise "pos not on board" unless on_board?(pos)
    i, j = pos
    @rows[i][j]
  end

  def display
    print "\n  "
    (0..BOARD_SIZE-1).each {|x| print " #{x} "}
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
      print " " + y.to_s + "\n"
    end
    print "  "
    (0..BOARD_SIZE-1).each {|x| print " #{x} "}
    print "\n\n"
  end

  def render
    @rows.map do |row|
      row.map {|spot| spot.icon unless spot.nil?}
    end
  end

  def update
    populate_rows
    make_men_into_kings
  end
#REV: Too many comments, don't need after every line
  def make_move(moves)
    if moves[1][1].is_a?(Array)
      return multiple_jumps(moves)
    end

    check_input(moves)

    from, to = moves
    y,x = from

    piece = @rows[y][x]
    y,x = to

    # check if it can slide
    if piece.possible_slide?(y,x)
      # if it can slide... SLIDE IT!
      piece.slide_to(y,x)
    else
      # check if it can jump
      if valid_jump?(moves)
        # if can jump... JUMP IT!
        piece.jump_to(y,x)
        between = between(from, to)
        # kill the piece in between
        self[between].current_pos = nil
      else
        raise "Invalid move."
      end
    end
  end

  protected

  def dup
    duped_board = Board.new
    duped_pieces = []

    @pieces.each do |piece|
      color = piece.color
      pos = piece.current_pos
      duped_piece = Piece.new(color, pos)
      duped_pieces << duped_piece
    end

    duped_board.pieces = duped_pieces
    duped_board.update
  end

  private

  def multiple_jumps(moves)
    raise "Invalid jump sequence" unless valid_jump_sequence?(moves)
    from, destinations = moves

    # if it's true we'll perform the whole sequence
    destinations.each do |destination|
      piece = self[from]
      y, x = destination
      piece.jump_to(y, x)
      from = destination
      update
    end
  end

  def valid_jump_sequence?(moves)
    from, destinations = moves

    duped_board = self.dup


    destinations.each do |destination|
      # check if the move is a valid jump
      # if so, perform it and check again
      move = [from, destination]
      return false unless valid_jump?(move)

      piece = duped_board[from]
      y, x = destination
      piece.jump_to(y, x)
      from = destination
      duped_board.update
    end

    true
  end

  def check_input(positions)
    from, to = positions

    raise "Your first position is invalid." unless on_board?(to)
    raise "Your second position is invalid." unless on_board?(from)
  end
	#REV: Should have a different variable name from method name (between)
	#little confusing
  def valid_jump?(move)
    from, to = move

    return false unless self[to].nil?

    between = between(from, to)

    moving_player = self[from]

    return false if self[between].nil?

    # is the spot between a player of a different color?
    self[between].color != moving_player.color
  end

  def populate_rows
    de_populate_rows
    @pieces.each do |piece|
      # a piece without a current_pos has been removed from the board.
      next if piece.current_pos.nil?
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
	#REV: I think this would use up unnecessary resources removing every piece
	# and then re-adding the piece after every move.  Unless you are planning to
	#add undo functionality, you could just set the piece to nil
  def de_populate_rows
    @rows.each_with_index do |row, y|
      row.each_index do |x|
        @rows[y][x] = nil
      end
    end
  end

  def between(from, to)
    y1, x1 = from
    y2, x2 = to

    y3 = (y2 < y1) ? y1 - 1 : y1 + 1
    x3 = (x2 > x1) ? x1 + 1 : x1 - 1

    [y3, x3]
  end

  def on_board?(pos)
    y, x = pos
    y < BOARD_SIZE && y >= 0 && x < BOARD_SIZE && x >= 0
  end

  def make_men_into_kings
    @pieces.each do |piece|
      next if piece.current_pos.nil?
      if piece.color == :white && piece.current_pos[0] == 0
        piece.king = true
        piece.icon = "\2654"
      elsif piece.color == :black && piece.current_pos[0] == (BOARD_SIZE-1)
        piece.king = true
        piece.icon = "\265A"
      end
    end
  end
end