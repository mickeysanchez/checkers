require 'socket'

send_socket = UDPSocket.new
send_socket.setsockopt(:SOCKET, :SO_BROADCAST, 1)

while message = gets
  send_socket.send message, 0, "255.255.255.255", 31338
end