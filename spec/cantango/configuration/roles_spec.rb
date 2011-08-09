require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'cantango/configuration/registry_shared'

describe CanTango::Configuration::Roles do
  it_should_behave_like "Registry" do
    subject { CanTango.config.roles }
  end
end



