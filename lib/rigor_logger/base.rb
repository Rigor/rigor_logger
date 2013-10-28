require 'rubygems'
require 'statsd'
require 'dogapi'

module RigorLogger

  class Base
    attr_reader :environment, :host, :name, :options

    def initialize name, options={}
      @environment = options[:environment] || 'development'
      @host = options[:host] || Socket.gethostname
      @name = name
      @options = set_options(options)
    end

    protected

    def set_tags opts
      t = opts[:tags] ? opts[:tags].concat(default_tags) : default_tags
      {:tags => t}
    end

    def default_tags
      ["environment:#{@environment}", "host:#{@host}"]
    end

    def set_options options
      options.merge(set_tags(options))
    end
  end

end
