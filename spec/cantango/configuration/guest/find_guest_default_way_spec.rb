require 'rspec'
require 'cantango'

class MyAccount
  def self.guest
    :guest_account
  end
end

class MyUser
  def self.guest
    :guest
  end
end

describe CanTango::Configuration::Guest do
  describe 'default settings with class methods for #guest defined' do
    before do
      CanTango.config.user.base_class = MyUser
      CanTango.config.user_account.base_class = MyAccount
    end

    subject { CanTango.config.guest }
      its(:default_user?)     { should be_true }
      its(:user)              { should == :guest }

      its(:default_account?)  { should be_true }
      its(:account)           { should == :guest_account }
  end
end



