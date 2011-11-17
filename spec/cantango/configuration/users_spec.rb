require 'rspec'
require 'cantango'
require 'cantango/configuration/shared/hash_registry_ex'

describe CanTango::Configuration::Users do
  subject { CanTango.config.users }

  it_should_behave_like "Hash Registry" do
  end
end
