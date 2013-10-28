require 'spec_helper'

describe RigorLogger::Base do
  
  describe 'using defaults' do
    it 'should require a name' do
      expect { RigorLogger::Base.new }.to raise_error ArgumentError
      expect { RigorLogger::Base.new 'test'}.to_not raise_error ArgumentError
      RigorLogger::Base.new('test').name.should eql('test')
    end

    it 'should have a default environment with tag' do
      logger = RigorLogger::Base.new('test')
      logger.environment.should eql('development')
      logger.options[:tags].include?('environment:development').should be_true
    end

    it 'should have a default host with tag' do
      logger = RigorLogger::Base.new('test')
      logger.host.should eql(Socket.gethostname)
      logger.options[:tags].include?("host:#{Socket.gethostname}").should be_true
    end
  end

  describe 'overriding defaults' do
    it 'should use options for environment' do
      logger = RigorLogger::Base.new('test', :environment => 'lala-land')
      logger.environment.should eql('lala-land')
      logger.options[:tags].include?('environment:lala-land').should be_true
    end

    it 'should use options for host' do
      logger = RigorLogger::Base.new('test', :host => 'my_host')
      logger.host.should eql('my_host')
      logger.options[:tags].include?("host:my_host").should be_true
    end
  end
end