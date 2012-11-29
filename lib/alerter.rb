class Alerter
  class << self
    def alert(msg, options ={})
      if mac?
        system "say \"#{msg}\""
      elsif linux?
        system "echo \"#{msg}\"|espeak"
      else
        # fuck it
      end
    end
  
    private
  
    def mac?
      RUBY_PLATFORM =~ /darwin/
    end
  
    def linux?
      RUBY_PLATFORM =~ /linux/
    end
  end
end