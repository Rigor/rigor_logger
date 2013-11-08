module RigorLogger
  
  class Event < Base

    # convenience methods
    def self.submit name, options={}
      new(name, options).submit
    end
    
    attr_reader :name, :options, :client
    
    def initialize name, options={}
      @client = Dogapi::Client.new(RigorLogger.config[:api_key])
      super
    end

    def submit
      @client.emit_event @name, @options
    end
  end

end