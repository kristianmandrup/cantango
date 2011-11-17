require 'rspec'
require 'cantango'
require 'cantango/configuration/shared/role_registry_ex'

describe CanTango::Configuration::Roles do
  subject { CanTango.config.roles }

  it_should_behave_like "Role Registry" do
    let (:has) { :has_role? }
    let (:list) { :roles_list }
  end
end



