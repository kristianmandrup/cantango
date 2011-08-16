require 'rspec'
require 'cantango'
require 'fixtures/models'

class AdminsRoleGroupPermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  protected

  def static_rules
  end
end

class AdminRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
  end
end

def setup
  let (:user) do
    User.new 'kris'
  end

  let (:user_account) do
    ua = UserAccount.new user, :role_groups => [:admins]
    user.account = ua
  end
end

describe CanTango::Permits::RolePermit::Finder do
  setup

  let (:finder) do
    CanTango::Permits::RolePermit::Finder.new user_account, :admin
  end

  describe 'attributes' do
    it "should have an ability" do
      finder.user_account.should be_a(UserAccount)
    end
  end

  describe '#permit_class' do
    it 'should return the :admin permit class' do
      finder.permit_class.should == "AdminRolePermit"
    end
  end
end

describe CanTango::Permits::RoleGroupPermit::Finder do
  setup

  let (:finder) do
    CanTango::Permits::RoleGroupPermit::Finder.new user_account, :admins
  end

  describe '#permit_class' do
    it 'should return the :admins role permit class' do
      finder.permit_class.should == "AdminsRoleGroupPermit"
    end
  end
end
