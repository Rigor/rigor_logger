require 'spec_helper'

describe RigorLogger::Metric do
  
  let(:logger) { RigorLogger::Metric.new('test') }

  describe 'using defaults' do
    it 'should have base attributes' do
      logger.name.should eql('test')
      logger.options.should be_a(Hash)
    end

    it 'should have a metric client' do
      logger.client.should_not be_nil
      logger.client.should be_an_instance_of(Statsd)
    end

    it 'should have a default metric server' do
      logger.server_host.should eql('localhost')
      logger.server_port.should == 8125
    end
  end

  describe '#increment' do
    before { Statsd.any_instance.stub(:increment).and_return('incremented!') }
    
    it 'should increment a counter' do
      logger.increment.should eql('incremented!')
    end

    it 'should increment conveniently' do
      RigorLogger::Metric.increment('test.event').should eql('incremented!')
    end
  end

  describe '#gauge' do
    before { Statsd.any_instance.stub(:gauge).and_return('gauged!') }

    it 'should require a value' do
      expect { RigorLogger::Metric.gauge 'test' }.to raise_error(ArgumentError)
      expect { RigorLogger::Metric.gauge 'test', :value => 123 }.to_not raise_error
    end

    it 'should gauge a metric' do
      logger.gauge.should eql('gauged!')
    end

    it 'should gauge conveniently' do
      RigorLogger::Metric.gauge('test.event', 123).should eql('gauged!')
    end
  end

  describe '#histogram' do
    before { Statsd.any_instance.stub(:histogram).and_return('histogrammed!') }

    it 'should require a value' do
      expect { RigorLogger::Metric.histogram 'test' }.to raise_error(ArgumentError)
      expect { RigorLogger::Metric.histogram 'test', :value => 123 }.to_not raise_error
    end

    it 'should histogram a metric' do
      logger.histogram.should eql('histogrammed!')
    end

    it 'should histogram conveniently' do
      RigorLogger::Metric.histogram('test.event', 123).should eql('histogrammed!')
    end
  end

  describe '#set' do
    before { Statsd.any_instance.stub(:set).and_return('set!') }

    it 'should require a value' do
      expect { RigorLogger::Metric.set 'test' }.to raise_error(ArgumentError)
      expect { RigorLogger::Metric.set 'test', :value => 123 }.to_not raise_error
    end

    it 'should set a metric' do
      logger.set.should eql('set!')
    end

    it 'should set conveniently' do
      RigorLogger::Metric.set('test.event', 123).should eql('set!')
    end
  end

  describe '#time' do
    before { Statsd.any_instance.stub(:time).and_return('timed!') }

    it 'should require a block' do
      expect { RigorLogger::Metric.time 'test' }.to raise_error(LocalJumpError)
      expect { RigorLogger::Metric.time('test') { a = 'hi' } }.to_not raise_error
    end

    it 'should time a block' do
      logger.time { a = 'hi' }.should eql('timed!')
    end

    it 'should time conveniently' do
      RigorLogger::Metric.time('test.event') { a = 'hi' }.should eql('timed!')
    end
  end

end