require 'spec_helper'
require 'fixtures/models'

class UserAccount
  tango_account
end

class AdminAccount
  tango_account
end

module AdminAccountPermits
  class EditorRolePermit < CanTango::RolePermit
  end
end

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

class AdminPermit < CanTango::UserPermit
  def initialize ability
    super
  end

  protected

  def static_rules
  end
end

class AdminAccountPermit < CanTango::AccountPermit
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

  let (:admin) do
    Admin.new 'kris'
  end

  let (:user_account) do
    ua = UserAccount.new user, :role_groups => [:admins]
    user.account = ua
  end

  let (:admin_account) do
    ua = AdminAccount.new user, :roles => [:editors], :role_groups => [:admins]
    admin.account = ua
  end
end

describe CanTango::Permits::RolePermit::Finder do
  setup

  context "Account" do
    let (:finder) do
      CanTango::Permits::RolePermit::Finder.new admin_account, :editor
    end

    describe 'attributes' do
      it "should have an ability" do
        finder.user_account.should be_a(AdminAccount)
      end
    end

    describe '#permit_class' do
      it 'should return the :admin permit class' do
        finder.permit_class.should == "EditorRolePermit"
      end
    end

    describe '#get_permit' do
      it 'should return the AdminAccount::EditorRolePermit' do
        finder.get_permit.should == AdminAccountPermits::EditorRolePermit
      end
    end

  end

  context "User" do
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
    
    describe '#get_permit' do
      it 'should return the AdminRolePermit' do
        finder.get_permit.should == AdminRolePermit
      end
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

  describe '#get_permit' do
    it 'should return the AdminsRoleGroupPermit class' do
      finder.get_permit.should == AdminsRoleGroupPermit
    end
  end

end

describe CanTango::Permits::UserPermit::Finder do
  setup

  let (:finder) do
    CanTango::Permits::UserPermit::Finder.new admin, :admin
  end

  describe '#permit_class' do
    it 'should return the :admin user permit class' do
      finder.permit_class.should == "AdminPermit"
    end
  end

  describe '#get_permit' do
    it 'should return AdminPermit class' do
      finder.get_permit.should == AdminPermit
    end
  end

end

describe CanTango::Permits::AccountPermit::Finder do
  setup

  let (:finder) do
    CanTango::Permits::AccountPermit::Finder.new admin_account, :admin
  end

  # We don't have AdminAccountPermits::AdminAccountPermit so it should fall back to single AdminAccountPermit

  describe '#permit_class' do
    it 'should return the :admin account permit class' do
      finder.permit_class.should == "AdminAccountPermit"
    end
  end
  
  describe '#get_permit' do
    it 'should return AdminAccountPermit class' do
      finder.get_permit.should == AdminAccountPermit
    end
  end

end
