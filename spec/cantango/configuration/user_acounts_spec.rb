require 'rspec'
require 'cantango'
require 'cantango/configuration/shared/hash_registry_ex'

describe CanTango::Configuration::UserAccounts do
  subject { CanTango.config.user_accounts }

  it_should_behave_like "Hash Registry" do
  end
end
