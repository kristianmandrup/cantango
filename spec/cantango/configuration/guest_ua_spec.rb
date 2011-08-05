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

require 'rspec'
require 'cantango'
require 'fixtures/models'


describe CanTango::Configuration::Guest do
  describe 'default settings with class methods for #guest defined' do
    subject { CanTango::Configuration.guest }
      its(:default_user?) { should be_true }
      its(:user_proc)     { should == :guest }

      its(:default_user_account?) { should be_true }
      its(:account_proc) { should == :guest_account }
  end
end



