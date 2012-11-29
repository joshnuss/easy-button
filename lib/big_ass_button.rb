require 'rubygems'
require 'serialport'

class BigAssButton
  BTN_COMMAND = 'PRESSED'
  
  def initialize(options = {})
    raise 'not found serial port has been' unless File.exists? options[:dev]
    @cmd = options[:cmd]
    @device = options[:dev]
    @port = options[:port] || 115200
    @count = 0
    @start_time = Time.now
  end
  
  def make_it_easy
    puts "Making It Easy™\n\n"
    SerialPort.open @device, @port do |port| 
      begin
        while data = port.readline
          if data.strip == BTN_COMMAND
            puts border
            
            puts "Executing: #{@cmd}"
            success = system @cmd
            puts success ? "Done, for now." : "Error: #{$?}"
            
            puts border
            @count += 1
            
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