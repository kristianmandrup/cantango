require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration::Guest do
  before do
    CanTango.config.user.base_class = User
    CanTango.config.user_account.base_class = UserAccount
  end

  subject { CanTango.config.guest }

  describe 'default settings' do
    it 'should not have defined UserAccount.guest' do
      UserAccount.should_not respond_to(:guest)
    end

    it 'should not have defined User.guest' do
      User.should_not respond_to(:guest)
    end

    its(:account) { should be_nil } # should be set to UserAccount.guest if defined
    its(:user)    { should be_nil } # should set to User.guest if defined ?
  end

  describe 'set user' do
    describe 'with obj arg' do
      before :each do
        subject.user = '2'
      end

      its(:user) { should == '2' }
    end

    describe 'with block arg' do
      before :each do
        subject.user { 2 }
      end

      its(:user) { should == 2 }
    end

    describe 'with Proc arg' do
      before :each do
        subject.user Proc.new { 2 }
      end

      its(:user) { should be_a Proc }
    end
  end

  describe 'set user account' do
    before :each do
      subject.account = '2'
    end

    its(:account) { should == '2' }
  end
end



