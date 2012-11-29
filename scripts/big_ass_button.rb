=begin
  Example Usage: ruby big_ass_button.rb /dev/ttyUSB0
=end

require 'rubygems'
require 'serialport'

raise 'forgot serial port parameter did you?' unless ARGV[0]
raise 'not found serial port has been' unless File.exists? ARGV[0]

SerialPort.open(ARGV[0], 115200) do |port| 
  loop do 
    data = port.read
    puts 'ohai' if data.strip == 'PRESSED'
    sleep 1
  end
end
