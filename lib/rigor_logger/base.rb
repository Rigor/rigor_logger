require 'rubygems'
require 'statsd'
require 'dogapi'

module RigorLogger

  class Base
    attr_reader :environment, :host, :name, :options

    def initialize name, options={}
      raise(ConfigurationError, 'Please provide an API key!') unless RigorLogger.config[:api_key]
      @host        = options[:host] || RigorLogger.config[:host]
      @environment = options[:environment] || RigorLogger.config[:environment]
      @name        = name
      @options     = set_options(options)
    end

    protected

    def set_tags opts
      t = opts[:tags] ? opts[:tags].concat(default_tags) : default_tags
      {:tags => t}
    end

    def default_tags
      RigorLogger.config[:default_tags].map {|tag| "#{tag}:#{self.send(tag)}"}
    end

    def set_options options
      options.merge(set_tags(options))
    end
  end

end
