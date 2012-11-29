=begin
  Example Usage: 
    Linux: ruby big_ass_button.rb /dev/ttyUSB0
    Mac: ruby big_ass_button.rb /dev/tty.usbmodem12341
=end

require 'rubygems'
require 'serialport'

class BigAssButton
  BTN_COMMAND = 'PRESSED'
  
  def initialize(device, port = 115200)
    raise 'not found serial port has been' unless File.exists? device
    @device = device
    @port = port
    @count = 0
    @start_time = Time.now
  end
  
  def make_it_easy
    puts "Making It Easy™\n\n"
    SerialPort.open @device, @port do |port| 
      begin
        while data = port.readline
          if data.strip == BTN_COMMAND
            puts "REBOOT SPHINX!"
            puts border
            
            #system File.expand_path('../lib/restart_sphinx.sh', Dir.pwd)
            
            puts border
            @count += 1
            puts "Done, for now."
            puts stats
          end
        end
      rescue Interrupt, EOFError
        puts "\rgoing bye bye now"
        puts stats(true)
      end
    end
  end
  
  private
  
  def stats(verbose = false)
    s = "Called #{@count} times\n#{"\n" unless verbose}"
    if verbose
      s << "Since: #{@start_time};\n"
      s << "Uptime: #{sprintf '%.4f', (Time.now.to_f - @start_time.to_f) / 60} mins"
    end
    s
  end
  
  def border
    '*'*80
  end
end