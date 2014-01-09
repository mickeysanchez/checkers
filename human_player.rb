class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def choose_move
    puts "#{@name}:"
    puts "Move from:"
    from = gets.chomp
    from = from.split(",").map(&:to_i)

    puts "Move to:"
    to = gets.chomp
    to = to.split(",").map(&:to_i)

    [from, to]
  end
end