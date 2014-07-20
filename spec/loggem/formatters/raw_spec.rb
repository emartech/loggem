require 'spec_helper'

describe Loggem::Formatters::Raw do

  describe "#call" do
    it "returns the raw data" do
      expect(subject.call 'raw-data').to eq 'raw-data'
    end
  end
end