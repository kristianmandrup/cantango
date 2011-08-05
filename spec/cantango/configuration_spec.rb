require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration do
  descrive "configure DSL" do
    before(:all) {
      CanTango.configure do |config|
        config.engines.permission :off
        config.engines.permit :off
      end
    }

    specify { CanTango::Configuration.engines.permit?.should be_false}
    specify { CanTango::Configuration.engines.permission?.should be_false}
  end
end
