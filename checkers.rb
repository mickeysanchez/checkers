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

    puts "#{@players.first.name}, #{@color_of_current_player}, has been defeated."
  end

  private

  def switch(color)
    @color_of_current_player =
    (@color_of_current_player == :white) ? :black : :white
  end

  def game_over?
    false
    # when there are no more pieces of color @color_of_current_player
  end
end

class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def choose_move
    "From:"
    # chooses two coordinates.
    # doesn't allow either coordinate to be invalid.
    "To:"
  end
end

h1 = HumanPlayer.new("Mickey")
h2 = HumanPlayer.new("Other Guy")
c = Checkers.new(h1,h2)
c.run
