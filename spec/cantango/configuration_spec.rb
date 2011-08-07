require 'rspec'
require 'cantango'
require 'fixtures/models'

class CanTango::CustomAbility < CanTango::Ability
  def initialize candidate, options = {}
    'custom'
  end
end

describe CanTango::Configuration do
  describe 'ability factory' do
    CanTango::Configuration.ability.factory do
      CanTango::CustomAbility.new
    end

    it 'should be substituted' do
      # magic!
    end
  end

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
