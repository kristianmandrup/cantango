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

  before do
    CanTango.debug_off!
  end

  describe 'attributes' do
    it "should be the permit for the :admin user" do
      permit.user_type.should == :admin
      permit.permit_name.should == :admin
    end

    it "should have an ability" do
      permit.ability.should be_a(CanTango::Ability)
    end
  end

  describe 'disable Admin Permit' do
    before do
      CanTango.config.permits.disable_for :user, [:admin, :editor]
    end

    it "should have an ability" do
      permit.disabled?.should be_true
    end
  end

  describe 'enable all Permits' do
    before do
      CanTango.config.permits.enable_all!
    end

    it "should be disabled" do
      CanTango.config.permits.disabled.should be_empty
      permit.disabled?.should be_false
    end
  end
end

