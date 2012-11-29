require 'rubygems'
require 'serialport'
require File.expand_path('alerter', File.dirname(__FILE__))

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
            
            Alerter.alert 'I am going to make this easy.'
            puts "Executing: #{@cmd}"
            
            success = system @cmd
            
            msg = success ? "I totally just restarted sphinx!" : "Error: #{$?}"
            Alerter.alert msg
            puts msg
            
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