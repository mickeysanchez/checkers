require_relative "board"
require_relative "piece"

class Checkers
  def initialize(player1, player2)
    @board = Board.new
    @color_of_current_player = :white
  end

  def run

  end
end

class HumanPlayer
  def initialize(name)
    @name = name
  end

  def choose_move

  end
end