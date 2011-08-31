require 'spec_helper'
require 'fixtures/models'

class AdminsRoleGroupPermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  protected

  def static_rules
  end
end

describe CanTango::PermitEngine::Factory do
  
  before do
    CanTango.config.cache_engine.set :off
  end

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

  let (:factory) do
    CanTango::PermitEngine::Factory.new ability
  end

  describe 'attributes' do
    it "should have an ability" do
      factory.ability.should be_a(CanTango::Ability)
    end
  end

  describe '#build!' do
    it 'should build a list of permits' do
      factory.build!.should_not be_empty
    end
  end
end
