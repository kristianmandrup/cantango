require 'spec_helper'
require 'fixtures/models'

class AdminAccountPermit < CanTango::AccountPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, Article
  end
end

describe CanTango::Permits::AccountPermit do
  let (:user) do
    User.new 'kris'
  end

  let (:user_account) do
    ua = UserAccount.new user, :roles => [:editor]
    user.account = ua
  end

  let (:ability) do
    CanTango::Ability.new user_account
  end

  let (:permit) do
    AdminAccountPermit.new ability
  end

  describe 'attributes' do
    it "should be the permit for the :admin account" do
      permit.account_type.should == :admin
    end

    it "should have an ability" do
      permit.ability.should be_a(CanTango::Ability)
    end
  end
end


