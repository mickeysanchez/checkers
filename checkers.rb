require_relative "board"
require_relative "piece"
require_relative "human_player"
require "debugger"

class Checkers
  def initialize(player1, player2)
    @board = Board.new
    @color_of_current_player = :white
    @players = [player1, player2]
  end

  def run
    until game_over?
      @board.display

      move_loop

      @board.update
      @players.rotate!
      switch(@color_of_current_player)
    end

    @board.display

    puts "#{@players.first.name}, of the color #{@color_of_current_player}, has been defeated."
  end


  private

  def move_loop
    begin
      move = @players.first.choose_move(@board)
      from = move[0]

      raise "You're trying to move nothing..." if @board[from].nil?
      raise "Move your own piece!" if @board[from].color != @color_of_current_player

      @board.make_move(move)

    rescue StandardError => e
      puts e
      retry
    end
  end

  def switch(color)
    @color_of_current_player =
    (@color_of_current_player == :white) ? :black : :white
  end

  def game_over?
    # when there are no more pieces of color @color_of_current_player
    !@board.pieces.any? { |piece| piece.color == @color_of_current_player }
  end
end

if __FILE__ == $PROGRAM_NAME
  h1 = HumanPlayer.new("Mickey")
  h2 = HumanPlayer.new("Other Guy")
  Checkers.new(h1,h2).run
end

