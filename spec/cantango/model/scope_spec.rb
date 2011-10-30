require 'rspec'
require 'cantango'
# require 'active_record/spec_helper'

require 'cutter'
require 'simple_roles'
require 'fixtures/models'
require 'cantango/api/current_users'
require 'cantango/api/current_user_accounts'

class User
  include_and_extend SimpleRoles
  tango_user
end

class Admin < User
  tango_user
end

class UserAccount
  tango_account # register
  include_and_extend SimpleRoles
end


class AdminAccount
  tango_account
  include_and_extend SimpleRoles
end


CanTango.configure do |config|
  config.cache_engine.set :off
  config.permit_engine.set :on
  config.ability.mode = :no_cache
end

class Context
  include CanTango::Api::User::Ability

  include_and_extend ::CurrentUsers
  include_and_extend ::CurrentUserAccounts
end

class UserRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  def permit_rules
    can :edit, Project
    can :create, Project
  end
end

class AdminRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  def permit_rules
    can :create, Project
    can :show, Project
  end
end

class Project
  include CanTango::Model::Scope

  attr_accessor :name

  def initialize name = 'proj'
    @name = name
  end

  def self.all
    [Project.new('a'), Project.new('b')]
  end
end

describe CanTango::Model::Scope do
  let(:context) { Context.new }

  subject { Project }

  describe 'Model scope API' do
    (CanTango::Model::Scope.rest_actions - [:edit, :create]).each do |action|
      meth_name = action.to_s.sub(/e$/, '') << "able"
      specify { subject.send(:"#{meth_name}_by", context.current_user).should be_empty }
    end

    (CanTango::Model::Scope.rest_actions - [:edit, :create]).each do |action|
      meth_name = action.to_s.sub(/e$/, '') << "able"
      specify { subject.send(:"not_#{meth_name}_by", context.current_user).should_not be_empty }
    end

    [:edit, :create].each do |action|
      meth_name = action.to_s.sub(/e$/, '') << "able"
      specify { subject.send(:"#{meth_name}_by", context.current_user).should_not be_empty }
    end

    describe '#allowed_to' do
      specify { subject.allowed_to(:create).by_user(context.current_user).should_not be_empty }

      specify { subject.allowed_to(:create, :edit).by_user(context.current_user).should_not be_empty }

      specify { subject.allowed_to(:delete).by_user(context.current_user).should be_empty }

      specify { subject.allowed_to(:delete, :manage).by_user(context.current_user).should be_empty }
    end

    describe '#not_allowed_to' do
      specify { subject.not_allowed_to(:create).by_user(context.current_user).should be_empty }
    end
  end
end


