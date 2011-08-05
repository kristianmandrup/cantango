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

class UserAccount
  def self.guest
    :guest_account
  end
end

class User
  def self.guest
    :guest
  end
end


describe CanTango::Configuration::Guest do
  describe 'default settings with class methods for #guest defined' do
    subject { CanTango::Configuration.guest }
      # TODO
      its(:account) { should == :guest_account }
      its(:user)    { should == :guest }
  end
end



