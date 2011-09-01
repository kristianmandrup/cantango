require 'rspec'
require 'cantango'

require 'cantango/configuration/shared/role_registry_ex'

class MyRegi < CanTango::Configuration::Registry
end

describe MyRegi do
  subject { MyRegi.new }

  it_should_behave_like "Registry" do
  end
end



