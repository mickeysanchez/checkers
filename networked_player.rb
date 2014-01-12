require "socket"

class NetworkedPlayer
  attr_reader :name

  def initialize(name)
    @name = name
    @send_socket = UDPSocket.new
    @send_socket.setsockopt(:SOCKET, :SO_BROADCAST, 1)
    @receive_socket = UDPSocket.new
    @receive_socket.bind "", 31338
  end

  def choose_move(board) 

      
    while message = "Move from:"
      puts "sending"
      10.times do
        @send_socket.send message, 0, "255.255.255.255", 31337
      end
      break
    end

    while from = @receive_socket.gets.chomp
      break
    end

    puts from
    
    from = from.split(",").map(&:to_i)

    message = "Move to:"
    @send_socket.send message, 0, "255.255.255.255", 31337
    
    until to = @receive_socket.gets.chomp
    end
    
    puts to

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