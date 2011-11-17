require 'rspec'
require 'cantango'
require 'cantango/configuration/shared/registry_ex'

describe CanTango::Configuration::Models do
  subject { CanTango.config.models }

  it_should_behave_like "Registry" do
  end
end
