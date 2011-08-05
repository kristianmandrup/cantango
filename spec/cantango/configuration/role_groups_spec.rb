require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration::RoleGroups do
  it_should_behave_like "Register" do
    subject { CanTango::Configuration.role_groups }
  end
end


