require 'rspec'
require 'cantango'
# require 'simple_roles'
require 'fixtures/models'
require 'cantango/rspec'

def config_folder
  File.dirname(__FILE__)+ "/../fixtures/config/"
end

CanTango.configure do |config|
  config.clear!
  config.ability.mode = :cache
end
# CanTango.debug!

class User
  tango_user
  include_and_extend SimpleRoles
end

class AdminRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, Article
  end

  module Cached
    def permit_rules
      can :edit, Article
      can :delete, Article
    end
  end
end

module CanTango
  class CachedAbility
    def permit_rules
      can :read, Post
    end
  end
end

describe CanTango::AbilityExecutor do
  context 'cached only' do
    before do
      CanTango.configure.ability.mode = :cache

      @user = User.new 'admin', 'admin@mail.ru', :role => 'admin'
      @abil = CanTango::AbilityExecutor.new @user
    end

    subject { CanTango::AbilityExecutor.new @user }

    describe 'config cache' do
      specify { CanTango.configure.ability.modes.should == [:cache] }
    end

    describe 'engines_on?' do
      specify { subject.engines_on?.should be_true }
    end

    its(:cached_rules)      { should_not be_empty }
    its(:non_cached_rules)  { should be_empty }

    describe 'rules contain only non-cached rules' do
      specify { subject.rules.size.should == @abil.cached_rules.size }
      specify { subject.rules.size.should == 4 }
    end
  end
end

