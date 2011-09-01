require 'rspec'
require 'cantango'

require 'cantango/configuration/shared/hash_registry_ex'

class MyReg < CanTango::Configuration::HashRegistry
end

describe MyReg do
  subject { MyReg.new }

  it_should_behave_like "Hash Registry" do
  end
end



