require 'spec_helper'

describe Loggem::Formatters::HumanReadable do

  describe "#call" do
    {
      {message: 'event worth to mention', duration: 123} => %Q{\n\tmessage: event worth to mention\n\tduration: 123},
      {message: "single ' quote"} => %Q{\n\tmessage: single ' quote},
      {message: "double \" quote"} => %Q{\n\tmessage: double " quote},
      {tags: %w[a b c]} => %Q{\n\ttags: ["a", "b", "c"]},
      {symbol: :symbol} => %Q{\n\tsymbol: symbol},
    }.each do |input, output|
      it "returns all data showing every keys in new lines" do
        expect(subject.call input).to eq output
      end
    end
  end
end