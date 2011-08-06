require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration do
  describe "configure DSL" do
    before(:all) {
      CanTango.configure do |config|
        CanTango::Configuration::Engines.available.each do |name|
          config.engine(name).set :off
        end
     end
    }

    CanTango::Configuration::Engines.available.each do |name|
      specify { CanTango::Configuration.engine(name).on?.should be_false}
      specify { CanTango::Configuration.engine(name).off?.should be_true}
    end
  end
end
