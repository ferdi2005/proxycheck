require 'socket'
require 'timeout'

def port_open?(ip, port, seconds=2)
  Timeout::timeout(seconds) do
    begin
      TCPSocket.new(ip, port).close
      true
    rescue Errno::ECONNREFUSED, Errno::EHOSTUNREACH
      false
    end
  end
rescue Timeout::Error
  false
end

puts "Inserire nome file e premere invio \n"
filename = gets.chomp
puts "Quanto tempo devo dare al server per rispondere \n"
timeout = gets.chomp.to_i

File.open(filename).each do |ip|
    [80, 1080, 3128, 8000, 8080, 8888].each do |port|
        if port_open?(ip.strip, port, timeout) == true
            @open = true
        end
    end
    if @open == true
        puts ip.strip + " è aperto"
    else
        puts ip.strip + " è chiuso"
    end
end