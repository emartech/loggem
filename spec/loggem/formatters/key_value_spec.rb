require 'spec_helper'

describe Loggem::Formatters::KeyValue do

  describe "#call" do
    {
      {message: 'event worth to mention'} => %q{message="event worth to mention"},
      {message: "single ' quote"} => %q{message="single ' quote"},
      {message: "double \" quote"} => %q{message="double \" quote"},
      {tags: %w[a b c]} => %q{tags="["a", "b", "c"]"},
      {symbol: :symbol} => %q{symbol="symbol"},
    }.each do |input, output|
      it "returns the data as key-value pairs" do
        expect(subject.call input).to eq output
      end
    end
  end
end