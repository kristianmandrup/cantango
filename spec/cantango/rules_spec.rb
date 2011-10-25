require 'rspec'
require 'cantango'
require 'fixtures/models'

class SystemRolePermit < CanTango::RolePermit
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
    ua = UserAccount.new user
    user.account = ua
  end

  let (:ability) do
    CanTango::Ability.new user_account
  end

  let (:permit) do
    SystemRolePermit.new ability
  end

  let (:executor) do
    CanTango::PermitEngine::Executor::System.new permit, user_account
  end
end


describe CanTango::Rules do
  setup

  describe '#can' do
    it "should not have any rules" do
      permit.rules.should be_empty
    end

    it "should have rules after can" do
      permit.can :read, Comment
      permit.rules.should_not be_empty
    end
  end
end


