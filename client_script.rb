require "socket"

receive_socket = UDPSocket.new
receive_socket.bind "", 31338

puts "#now listening"

# while message = receive_socket.gets.chomp
#   puts message
# end
p receive_socket.recvfrom(10000).first