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
    to = gets.chomp

    # recognizes and parses a multiple jump sequence
    if to.include?(" ")
      to = to.split(" ")
      to = to.map! { |coord| coord.split(",").map(&:to_i) }
      p to
    else
      to = to.split(",").map(&:to_i)
    end

    [from, to]
  end
end