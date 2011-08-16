require 'spec_helper'
require 'fixtures/models'

class AdminPermit < CanTango::UserPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, Article
  end
end


describe CanTango::Permits::UserPermit do
  let (:user) do
    User.new 'kris'
  end

  let (:ability) do
    CanTango::Ability.new user
  end

  let (:permit) do
    AdminPermit.new ability
  end

  describe 'attributes' do
    it "should be the permit for the :admin user" do
      permit.user_type.should == :admin
    end

    it "should have an ability" do
      permit.ability.should be_a(CanTango::Ability)
    end
  end
end

