require 'spec_helper'
require 'fixtures/models'

class SystemRolePermit < CanTango::RolePermit
end

describe CanTango::PermitEngine::Builder::SpecialPermits do

  before do
    CanTango.config.cache_engine.set :off
  end

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

  let (:builder) do
    CanTango::PermitEngine::Builder::SpecialPermits.new ability
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
