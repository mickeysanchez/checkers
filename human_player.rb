class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def choose_move(board)
    puts "#{@name}:"
    puts "Move from:"
    from = gets.chomp
    from = from.split(",").map(&:to_i)

    puts "Move to:"
    puts "(Add a space between coordinates to perform multiple jumps.)"
    to = gets.chomp

    # recognizes and parses a multiple jump sequence
    if to.include?(" ")
      to = to.split(" ")
      to = to.map! { |coord| coord.split(",").map(&:to_i) }
    else
      to = to.split(",").map(&:to_i)
    end

    [from, to]
  end
end