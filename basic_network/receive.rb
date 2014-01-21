require 'socket'

receive_socket = UDPSocket.new
receive_socket.bind "", 31338

while message = receive_socket.gets.chomp
  puts message
end