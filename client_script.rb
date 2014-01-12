require "socket"

receive_socket = UDPSocket.new
receive_socket.bind "", 31337


puts "#now listening"

loop do 

  puts "receive"
  while message = receive_socket.gets.chomp
    puts "> " + message
    break
  end
  
  send_socket = UDPSocket.new
  send_socket.setsockopt(:SOCKET, :SO_BROADCAST, 1)

  puts "send"
  while message = gets
    send_socket.send message, 0, "255.255.255.255", 31338
    break
  end
  
end