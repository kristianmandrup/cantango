require 'rspec'
require 'cantango'
require 'simple_roles'
require 'fixtures/models'
require 'cantango/api/current_users'
require 'cantango/api/current_user_accounts'

class User
  include_and_extend SimpleRoles
end

class Admin < User
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
  config.users.register :user, User
  config.users.register :admin, Admin

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

    can :has_role?, Project
    can :is_done?, Project
    can :destroy!, Project

    can :done!, Project
    can :edit, Project
    can :publish, Project
    can :assign_to, Project
  end
end

class Project
  include CanTango::Model::Filter

  tango_filter :publish, :edit, :DELETE, :is_done?, :done!
  tango_filter :assign_to => [:user], :create => :OPTS, :show => [:ARGS], :has_role? => :role

  def create options = {}
    options
  end

  def show *args
    args.flatten.compact
  end

  def is_done?
    false
  end

  def has_role? role
    true
  end

  def done!
    "done"
  end

  def publish
    "publish"
  end

  def destroy!
    "destroy!"
  end

  def edit
    "edit"
  end

  def assign_to user
    user
  end
end

describe CanTango::Model::Filter do
  let(:context) { Context.new }

  subject { Project.new }

  describe '#tango_filter' do

    describe 'block access to model method due to permission rule' do
      specify { subject.publish_by(context.current_user).should be_nil }
    end

    describe 'allow access to model method due to permission rule' do
      specify { subject.publish_by(context.current_admin).should == "publish" }
    end

    describe 'handle method with args' do
      specify { subject.assign_to_by(context.current_admin, context.current_user).should == context.current_user }
      specify { subject.assign_to_by(context.current_user, context.current_admin).should be_nil }
    end

    describe 'handle method with *args' do
      specify { subject.show_by(context.current_admin, 'love', nil, 'hate').should == ['love', 'hate'] }
    end

    describe 'handle method with options' do
      specify { subject.create_by(context.current_admin, :love => 5, :hate => 2).should == {:love => 5, :hate => 2} }
    end

    describe 'handle method with ? postfix' do
      specify { subject.has_role_by?(context.current_admin, 'editor').should be_true }
      specify { subject.is_done_by?(context.current_admin).should be_false }
    end

    describe 'handle method with ! postfix' do
      specify { subject.done_by!(context.current_admin).should == 'done' }
    end

    describe 'handle special REST method - DELETE' do
      specify { subject.destroy_by!(context.current_admin).should == 'destroy!' }
    end
  end

  describe '#tango_account_filter' do
    describe 'block access to model method due to permission rule' do
      specify { subject.publish_by(context.current_user_account).should be_nil }
    end

    describe 'allow access to model method due to permission rule' do
      specify { subject.publish_by(context.current_admin_account).should == "publish" }
    end
  end
end

