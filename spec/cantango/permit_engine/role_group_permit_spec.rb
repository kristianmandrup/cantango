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

describe CanTango::Permits::RoleGroupPermit do
  let (:user) do
    User.new 'kris'
  end

  let (:user_account) do
    ua = UserAccount.new user, :role_groups => [:admins]
    user.account = ua
  end

  let (:ability) do
    CanTango::Ability.new user_account
  end

  let (:permit) do
    AdminsRoleGroupPermit.new ability
  end

  describe 'attributes' do
    it "should be the permit for the :admins group" do
      permit.role_group.should == :admins
    end

    it "should have an ability" do
      permit.ability.should be_a(CanTango::Ability)
    end
  end
end
