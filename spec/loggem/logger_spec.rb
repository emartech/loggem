require 'spec_helper'

describe Loggem::Logger do
  let(:logger) { double 'Logger' }

  subject { Loggem::Logger.new logger }

  describe "use formatters" do
    let(:default_formatter) { double 'Default Formatter' }

    before(:each) do
      allow(Loggem::Formatters::Json).to receive(:new).and_return(default_formatter)
      allow(logger).to receive(:info)
    end


    it "should use the default formatter if none provided" do
      expect(default_formatter).to receive(:call).with(at: :info, message: 'log message')

      subject.info 'log message'
    end


    it "should use custom formatter if none provided" do
      formatter = double 'Formatter'

      expect(formatter).to receive(:call).with(at: :info, message: 'log message')

      subject.formatter = formatter
      subject.info 'log message'
    end


    it "should raise error if formatter doesn't respond to call" do
      expect {
        subject.formatter = nil
      }.to raise_error ArgumentError, "Formatter must respond to 'call'"
    end


  end


  describe 'delegate unknown messages to logger' do
    it "delegates message 'level=' to the logger" do
      expect(logger).to receive(:level=).with 'desired log level'

      subject.level = 'desired log level'
    end
  end


  describe 'logging messages' do
    let(:event) { double 'Event', data: 'event hash' }
    let(:formatter) { double 'Formatter' }

    before(:each) do
      allow(formatter).to receive(:call).with('event hash').and_return 'formatted message'
    end


    [:debug, :info, :warn, :error, :fatal].each do |level|
      it "should log a #{level} message" do
        allow(::Loggem::Event).to receive(:new).
                                    with(level: level, message: 'raw message', payload: {}, context: {}).
                                    and_return(event)
        expect(logger).to receive(level).with('formatted message')

        subject.formatter = formatter
        subject.send level, 'raw message'
      end
    end


    it 'should log a message with payload' do
      allow(::Loggem::Event).to receive(:new).
                                  with(level: :info, message: 'raw message', payload: 'payload', context: {}).
                                  and_return(event)
      expect(logger).to receive(:info).with('formatted message')

      subject.formatter = formatter
      subject.info 'raw message', 'payload'
    end


    it 'should log multiple messages with the same context' do
      allow(::Loggem::Event).to receive(:new).
                                  with(level: :info, message: 'raw message', payload: {}, context: {request_id: 123}).
                                  and_return(event)

      expect(logger).to receive(:info).with('formatted message').twice

      subject.formatter = formatter
      subject.context[:request_id] = 123

      subject.info 'raw message'
      subject.info 'raw message'
    end

  end

end
