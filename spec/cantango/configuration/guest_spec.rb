require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration::Guest do
  describe 'default settings' do
    subject { CanTango::Configuration.guest }
      # TODO
      its(:account) { should be_nil } # should be set to UserAccount.guest if defined
      its(:user)    { should be_nil } # should set to User.guest if defined ?
  end
end

