require 'spec_helper'

module AdminAccountPermits
class AdminRolePermit < CanTango::RolePermit
end
end

class MusicianRolePermit < CanTango::RolePermit; end
class EditorsRoleGroupPermit < CanTango::RoleGroupPermit; end
class AdminAccountPermit < CanTango::AccountPermit; end

describe CanTango::Permits::Permit do

  it "should register various permits" do
    CanTango.config.permits.admin_account.role[:admin].should == AdminAccountPermits::AdminRolePermit
    CanTango.config.permits.role[:musician].should == MusicianRolePermit
    CanTango.config.permits.role_group[:editors].should == EditorsRoleGroupPermit
    CanTango.config.permits.account[:admin].should == AdminAccountPermit

  end
end
