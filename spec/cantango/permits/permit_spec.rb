require 'spec_helper'

module AdminAccountPermits
class AdminRolePermit < CanTango::RolePermit
end
end

class MusicianRolePermit < CanTango::RolePermit; end

class AdminAccount
  tango_user_account
end


describe CanTango::Permits::Permit do

  it "should register account permits" do
    puts "---- #{CanTango.config.permits.admin_account.role[:admin]}"
  end
end
