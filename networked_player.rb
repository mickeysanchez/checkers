require "socket"




class NetworkedPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def choose_move(board) 
    send_socket = UDPSocket.new

    send_socket.setsockopt(:SOCKET, :SO_BROADCAST, 1)

    receive_socket = UDPSocket.new

    receive_socket.bind "", 31338
    
    
    message = "#{@name}: \n Move from: \n"
    send_socket.send message, 0, "255.255.255.255", 31337

    while from = receive_socket.gets.chomp
    end
    
    from = from.split(",").map(&:to_i)

    message = "Move to: \n (Add a space between coordinates to perform multiple jumps.)"
    
    while to = receive_socket.gets.chomp
    end

    # recognizes and parses a multiple jump sequence
    if to.include?(" ")
	#REV combine the "to" stuff into 1 longer line; less clarity but gives more brevity
      to = to.split(" ")
      to = to.map! { |coord| coord.split(",").map(&:to_i) }
    else
      to = to.split(",").map(&:to_i)
    end
    
    
    [from, to]
  end
end