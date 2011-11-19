require 'rspec'
require 'cantango'

describe CanTango::Configuration::Modes do
  subject { CanTango.config.modes }

  specify { subject.should include(:cache, :no_cache) }

  describe 'valid mode=' do
    before do
      subject.mode = :cache
    end
    specify { subject.modes.should == [:cache] }
  end

  describe 'invalid mode=' do
    before do
      subject.mode = :cachy!
    end
    specify { subject.modes.should_not include(:cachy!) }
  end
end
