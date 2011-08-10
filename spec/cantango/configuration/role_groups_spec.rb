require 'rspec'
require 'cantango'

require 'cantango/configuration/shared/role_registry_ex'

describe CanTango::Configuration::RoleGroups do
  subject { CanTango.config.role_groups }

  it_should_behave_like "Role Registry" do
    let (:has)  { :in_role_group? }
    let (:list) { :role_groups_list }
  end
end


