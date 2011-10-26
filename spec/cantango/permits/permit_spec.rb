require 'spec_helper'

module AdminAccountPermits
class AdminRolePermit < CanTango::RolePermit
end
end

class MusicianRolePermit < CanTango::RolePermit; end
class EditorsRoleGroupPermit < CanTango::RoleGroupPermit; end
class AdminAccountPermit < CanTango::AccountPermit; end
class AdminPermit < CanTango::UserPermit; end

describe CanTango::Permits::Permit do

  it "should register RolePermit-based permits" do
    CanTango.config.permits.admin_account.role[:admin].should == AdminAccountPermits::AdminRolePermit
    CanTango.config.permits.role[:musician].should == MusicianRolePermit
  end

  it "should register RoleGroupPermit-based permits" do
    CanTango.config.permits.role_group[:editors].should == EditorsRoleGroupPermit
  end

  it "should register UserPermit-based permits" do
    CanTango.config.permits.user[:admin].should == AdminPermit
  end
  it "should register AccountPermit-based permits" do
    CanTango.config.permits.account[:admin].should == AdminAccountPermit
  end

  context "registration of double-inherited permits (fx RolePermit ones) - specially for Kris ;)" do
    before do
      class GuitaristRolePermit < MusicianRolePermit; end
      class AdminAccountPermits::AngryAdminRolePermit < AdminAccountPermits::AdminRolePermit; end
    end

    it "should register basic namespaced" do
      CanTango.config.permits.role[:guitarist].should == GuitaristRolePermit
    end

    it "should register account-namespaced" do
      CanTango.config.permits.admin_account.role[:angry_admin].should == AdminAccountPermits::AngryAdminRolePermit
    end

  end
end
