require 'spec_helper'
require 'fixtures/models'

class AdminRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
  end
end


describe CanTango::Permits::RolePermit do
  let (:user) do
    User.new 'kris'
  end

  let (:user_account) do
    ua = UserAccount.new user, :roles => [:admin]
    user.account = ua
  end

  let (:ability) do
    CanTango::Ability.new user_account
  end

  let (:permit) do
    AdminRolePermit.new ability
  end

  describe 'attributes' do
    it "should be the permit for the :admin role" do
      permit.role.should == :admin
    end

    it "should have an ability" do
      permit.ability.should be_a(CanTango::Ability)
    end
  end
end
