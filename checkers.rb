require_relative "board"
require_relative "piece"

class Checkers
  def initialize(player1, player2)
    @board = Board.new
    @color_of_current_player = :white
    @players = [player1, player2]
  end

  def run
    until game_over?
      @board.display
      @players.first.choose_move
      @players.rotate!
      switch(@color_of_current_player)
    end
  end

  private

  def switch(color)
    @color_of_current_player =
    (@color_of_current_player == :white) ? :black : :white
  end
end

class HumanPlayer
  def initialize(name)
    @name = name
  end

  def choose_move

  end
end