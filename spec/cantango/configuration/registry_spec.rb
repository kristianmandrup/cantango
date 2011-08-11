require 'rspec'
require 'cantango'

require 'cantango/configuration/shared/role_registry_ex'

class MyReg < CanTango::Configuration::Registry
end

describe MyReg do
  subject { MyReg.instance }

  it_should_behave_like "Registry" do
  end
end



