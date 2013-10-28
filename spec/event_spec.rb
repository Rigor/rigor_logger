require 'spec_helper'

describe RigorLogger::Event do
  
  let(:logger) { RigorLogger::Event.new('test') }

  describe 'using defaults' do
    it 'should have base attributes' do
      logger.name.should eql('test')
      logger.options.should be_a(Hash)
    end

    it 'should have an event client' do
      logger.client.should_not be_nil
      logger.client.should be_an_instance_of(Dogapi::Client)
    end
  end

  describe '#submit' do
    it 'should submit events using the client' do
      Dogapi::Client.any_instance.stub(:emit_event).and_return('submitted!')
      logger.submit.should eql('submitted!')
    end

    it 'should submit conveniently' do
      Dogapi::Client.any_instance.stub(:emit_event).and_return('submitted!')
      RigorLogger::Event.submit('test.event').should eql('submitted!')
    end
  end

end