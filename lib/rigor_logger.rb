require "rigor_logger/version"
require 'rigor_logger/base'
require 'rigor_logger/event'
require 'rigor_logger/metric'

module RigorLogger
  @config = {
    :api_key      => nil,
    :host         => Socket.gethostname,
    :environment  => 'development',
    :server_host  => 'localhost',
    :app          => nil,
    :server_port  => 8125,
    :default_tags => [:environment, :host]
  }

  class << self
    attr_accessor :config
  end

  class ConfigurationError < Exception
  end
end