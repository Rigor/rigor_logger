module RigorLogger
  
  class Metric < Base

    # convenience methods
    def self.increment name, options={}
      new(name, options).increment
    end

    def self.gauge name, value, options={}
      new(name, options.merge(:value => value)).gauge
    end

    def self.histogram name, value, options={}
      new(name, options.merge(:value => value)).histogram
    end

    def self.set name, value, options={}
      new(name, options.merge(:value => value)).set
    end

    def self.time name, options={}, &block
      new(name, options).time &block
    end

    attr_reader :name, :value, :options, :client, :server_host, :server_port

    def initialize name, options={}
      @server_host = options[:server] ? options[:server][:host] : 'localhost'
      @server_port = options[:server] ? options[:server][:port] : 8125
      @client = Statsd.new(@host, @port)
      @value = options[:value]
      super
    end

    def increment
      @client.increment @name, @options
    end

    def gauge
      @client.gauge @name, @value, @options
    end

    def histogram
      @client.histogram @name, @value, @options
    end

    def set
      @client.set @name, @value, @options
    end

    def time &block
      raise(LocalJumpError, 'no block given') unless block_given?
      @client.time @name, @options, &block
    end
  end

end