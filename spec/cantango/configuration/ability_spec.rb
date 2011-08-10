require 'rspec'
require 'cantango'

require 'cantango/configuration/shared/factory_ex'

describe CanTango::Configuration::Ability do

  it_should_behave_like 'Factory' do
    subject { CanTango.config.ability }
  end
end


