require 'rspec'
require 'cantango'
require 'fixtures/models'

@user = User.new('kris', 'kris@gmail.com')

class CanTango::CustomAbility < CanTango::Ability
  def initialize candidate, options = {}
    'custom'
  end
end

describe CanTango::Configuration do
  describe "configure DSL" do
    before(:all) {
      CanTango.configure do |config|
        CanTango.config.engines.available.each do |name|
          config.engine(name).set :off
        end
     end
    }

    CanTango.config.engines.available.each do |name|
      specify { CanTango.config.engine(name).on?.should be_false}
      specify { CanTango.config.engine(name).off?.should be_true}
    end
  end
end
