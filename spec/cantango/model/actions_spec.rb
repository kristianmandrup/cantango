require 'rspec'
require 'cantango'
require 'simple_roles'
require 'fixtures/models'
require 'cantango/api/current_users'
require 'cantango/api/current_user_accounts'

class User
  tango_user

  include_and_extend SimpleRoles
end

class Admin < User
  tango_user
end


CanTango.configure do |config|
  config.cache_engine.set :off
  config.permit_engine.set :on
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
    cannot :publish, Project
  end
end

class AdminRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  def permit_rules
    can :create, Project
    can :show, Project

    can :publish, Project
  end
end

class Project
  include CanTango::Model::Actions

  tango_actions :search, :as => :collection

  tango_actions :publish, :tag, :as => :member
end

describe CanTango::Model::Filter do
  let(:context) { Context.new }

  subject { CanTango.config.models.actions }

  describe '#tango_actions' do

    describe 'registered model actions' do
      it 'should have registered :search as a collection action' do
        subject[:project].actions_for(:collection).should include(:search)
      end

      it 'should have registered :publish as a member action' do
        subject[:project].actions_for(:member).should include(:publish)
      end

      it 'should have registered :tag as a member action' do
        subject[:project].actions_for(:member).should include(:publish)
      end
    end
  end
end

