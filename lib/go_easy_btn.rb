require 'rubygems'
require 'serialport'
require 'alerter'

class GoEasyButton
  BTN_COMMAND = 'PRESSED'
  
  def initialize(options = {})
    raise Errno::ENOENT, 'not found serial port has been' unless File.exists? options[:dev]
    @cmd = options[:cmd]
    @device = options[:dev]
    @baud = options[:baud] || 115200
    @count = 0
    @start_time = Time.now
  end
  
  def make_it_easy
    SerialPort.open @device, @baud do |port| 
      begin
        puts "Making It Easy\n\n"
        while data = port.readline
          run_command if data.strip == BTN_COMMAND
        end
      rescue Interrupt
        puts "\rgoing bye bye now", stats(true)
      rescue EOFError
        handle_disconnect
      end
    end
  end
  
  protected
  
  def run_command
    puts border
    
    Thread.new { Alerter.alert 'I am going to make this easy?' }
    puts "Executing: #{@cmd}"
    
    success = system @cmd
    
    msg = if success
      @count += 1
      "That was easy!"
    else
      "Error: #{$?}"
    end
    
    Alerter.alert msg
    puts msg, border, stats
  end
  
  def handle_disconnect(msg = 'disconnected')
    make_it_easy
  rescue Errno::ENOENT # still not connected
    sleep 1
    retry
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
