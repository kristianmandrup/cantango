require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration::Guest do
  describe 'default settings' do
    subject { CanTango::Configuration.guest }

      it 'should not have defined UserAccount.guest' do
        UserAccount.should_not respond_to(:guest)
      end

      it 'should not have defined User.guest' do
        User.should_not respond_to(:guest)
      end

      # TODO
      its(:account_proc) { should be_nil } # should be set to UserAccount.guest if defined
      its(:user_proc)    { should be_nil } # should set to User.guest if defined ?
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
      its(:account_proc) { should == :guest_account }
      its(:user_proc)    { should == :guest }
  end
end



