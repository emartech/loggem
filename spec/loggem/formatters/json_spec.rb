require 'spec_helper'

describe Loggem::Formatters::Json do

  describe "#call" do
    it "returns the JSON encoded data" do
      allow(JSON).to receive(:dump).with('raw-data').and_return 'json-data'

      expect(subject.call 'raw-data').to eq 'json-data'
    end
  end
end