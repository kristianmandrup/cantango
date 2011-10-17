require 'rspec'
require 'cantango'
require 'simple_roles'
require 'fixtures/models'
require 'cantango/api/current_users'

class User
  include_and_extend SimpleRoles
end

class Admin < User
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
 
    can :edit, Project
    can :publish, Project
    can :assign_to, Project
  end
end

class Project
  include CanTango::Filter

  tango_filter :publish, :edit
  tango_filter :assign_to => [:user], :create => :OPTS, :show => [:ARGS]

  def create options = {}
    options
  end

  def show *args
    args.flatten.compact
  end

  def publish
    "publish"
  end

  def edit
    "edit"
  end

  def assign_to user
    user
  end
end

describe CanTango::Filter do
  let(:context) { Context.new }

  subject { Project.new }

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
end

