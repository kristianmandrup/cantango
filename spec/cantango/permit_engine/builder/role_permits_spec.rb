require 'spec_helper'
require 'fixtures/models'

CanTango.config.cache_engine.set :off
class AdminsRoleGroupPermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  protected

  def static_rules
  end
end

class AdminRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
  end
end


describe CanTango::Permits::RolePermit::Builder do
  let (:user) do
    User.new 'kris'
  end

  let (:user_account) do
    ua = UserAccount.new user, :role_groups => [:admins], :roles => [:admin]
    user.account = ua
  end

  let (:ability) do
    CanTango::Ability.new user_account
  end

  let (:builder) do
    CanTango::Permits::RolePermit::Builder.new ability
  end

  describe 'attributes' do
    it "should have an ability" do
      builder.ability.should be_a(CanTango::Ability)
    end
  end

  describe '#build' do
    it 'should build a list of permits' do
      builder.build.should_not be_empty
    end
  end
end
