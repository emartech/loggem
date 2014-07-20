require 'spec_helper'

describe Loggem::Event do
  subject { Loggem::Event }

  describe 'parsing strings' do
    it 'should return the parsed message' do
      event = subject.new level: :info, message: 'string'

      expect(event.data).to eq(at: :info, message: 'string')
    end

    it 'should strip the leading and trailing spaces' do
      event = subject.new level: :info, message: '  string  '

      expect(event.data).to eq(at: :info, message: 'string')
    end
  end


  describe 'parsing exceptions' do
    let(:exception) { StandardError.new 'error message' }

    it 'should handle exceptions with no stacktrace' do
      event = subject.new level: :info, message: exception

      expect(event.data).to eq(at: :info, message: 'error message')
    end

    it 'should log the stacktrace of exceptions (up to 5 lines)' do
      exception.set_backtrace Array.new(8) { |i| "line#{i}" }

      event = subject.new level: :info, message: exception

      expect(event.data).to eq(at: :info, message: 'error message', stacktrace: "line0\nline1\nline2\nline3\nline4")
    end

  end


  describe 'logging arbitrary objects' do
    it 'should not fail' do
      event = subject.new level: :info, message: Object.new


      expect { event.data }.to_not raise_error
    end
  end


  describe 'logging Hash' do
    it 'should pass it as-is' do
      event = subject.new level: :info, message: {foo: 'bar'}

      expect(event.data).to eq(at: :info, foo: 'bar')
    end
  end


  describe 'logging extra information' do
    it 'should add any extra information given in a Hash without changes' do
      event = subject.new level: :info, message: 'sh!t happen', payload: {customer: 123}

      expect(event.data).to eq(at: :info, message: 'sh!t happen', customer: 123)
    end
  end


  describe 'logging context information' do
    it "should log the context in every log message" do
      event = subject.new level: :info, message: 'sh!t happen', context: {request_id: 123}

      expect(event.data).to eq(at: :info, message: 'sh!t happen', request_id: 123)
    end
  end
end
