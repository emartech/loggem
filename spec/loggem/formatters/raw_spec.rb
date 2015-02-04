require 'spec_helper'

describe Loggem::Formatters::Raw do

  describe "#call" do
    let(:data) { double 'raw data' }

    it "returns the raw data" do
      expect(subject.call data).to be data
    end
  end
end