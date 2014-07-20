require 'spec_helper'


describe Loggem do

  describe ".rails_setup" do
    let(:config) { double 'Config', loggem: double(enabled: true, logger: 'custom logger', formatter: 'custom formatter') }
    let(:rails) { double 'Rails Application', config: config }
    let(:loggem) { double 'Loggem instance' }


    it "should setup rails integration" do
      allow(::Loggem::Logger).to receive(:new).with('custom logger').and_return(loggem)

      expect(loggem).to receive(:formatter=).with('custom formatter')
      expect(config).to receive(:logger=).with(loggem)

      subject.setup_rails(rails)
    end

  end
end