# RigorLogger

Wrapper to send metrics and events to DataDog

## Installation

Add this line to your application's Gemfile:

    gem 'rigor_logger'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install rigor_logger

## Usage

### Configuration
Configure your API key to send to DataDog. For Rails, this could go in ```config/initializers/rigor_logger.rb```
```ruby
RigorLogger.config.merge! :api_key      => 'my-datadog-apikey', # required
                          # hostname tag (Socket.gethostname default)
                          :host         => 'hostname',          
                          # the server running dogstatsd (localhost default)
                          :server_host  => 'myserver.com',      
                          # the port for dogstatsd server (8125 default)
                          :server_port  => 1234,
                          # an environment tag ('development' default)
                          :environment  => Rails.env,
                          # an app tag (nil default)
                          :app          => 'my.app.com',
                          # what tags to include by default
                          :default_tags => [:environment, :host, :app]
```

### Metrics
```ruby
# create a metric
metric = RigorLogger::Metric.new('namespace.my_cool_metric')

# send it to DataDog
metric.increment

# or use convenience method
RigorLogger::Metric.increment('namespace.my_cool_metric')
```

__Metric types__

```ruby
# increment a counter
RigorLogger::Metric.increment('name')

# update state
RigorLogger::Metric.gauge('name', 123)

# track distributions
RigorLogger::Metric.histogram('name', 123)

# add to a set
RigorLogger::Metric.set('name', 123)

# time a block of code
RigorLogger::Metric.time('name') { puts 'time this code block!' }
```
__Default Options__

By default, metrics are sent with host and environment tags. These can be passed as options as well.
```ruby
options = {
    :host        => 'some_hostname',    # defaults to Socket.gethostname
    :environment => 'staging'           # defaults to 'development'
}
```

__Additional Options__
```ruby
metric_options = {
    :tags           => ['my_tag'],          # tags for reporting dimensions
    :sample_rate    => 0.5,                 # only send data half the time
}
```

### Events
__[DataDog API docs](http://docs.datadoghq.com/api/#events)__
```ruby
# create an event
event = RigorLogger::Event.new('my_event')

# send it to DataDog
event.submit

# or use convenience method
RigorLogger::Event.submit('my_event')
```

__Default Options__

By default, events are sent with host and environment tags. These can be passed as options as well.
```ruby
options = {
    :host        => 'some_hostname',    # defaults to Socket.gethostname
    :environment => 'staging'           # defaults to 'development'
}

RigorLogger::Event.new 'my_event', options
```
__Additional Options__
```ruby
event_options = {
    :msg_title      => 'My Event Title',    # default: ''
    :date_happened  => 1.day.ago,           # default: now
    :priority       => 'normal',            # 'normal' or 'low' - default 'normal'
    :tags           => ['my_tag'],          # tags for reporting dimensions
    :alert_type     => 'info',              # 'info', 'warning', 'success', or 'error'
    :aggregation_key => 'some_key',         # string to use for aggregation
    :source_type_name => 'event_source'     # event type: nagios, hudson, jenkins, user, my apps, feed, chef, puppet, git, bitbucket, fabric, capistrano
}
```
