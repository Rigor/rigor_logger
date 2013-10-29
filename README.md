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

### Events
```ruby
# create an event
event = RigorLogger::Event.new('my_event')

# send it to DataDog
event.submit

# or use convenience method
RigorLogger::Event.submit('my_event')
```

## Defaults

By default, metrics and events are sent with host and environment tags. These can be passed as options as well.
```ruby
options = {
    :host        => 'some_hostname',    # defaults to Socket.gethostname
    :environment => 'staging'           # defaults to 'development'
}

RigorLogger::Event.new 'my_event', options
```
