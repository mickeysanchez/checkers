require "socket"

class NetworkedPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def choose_move(board)

    send_socket = UDPSocket.new
    send_socket.setsockopt(:SOCKET, :SO_BROADCAST, 1)

    board = board.render

    send_socket.send board.first.join("-"), 0, "255.255.255.255", 31338


    puts "enter move"
    move = gets.chomp
  end
end