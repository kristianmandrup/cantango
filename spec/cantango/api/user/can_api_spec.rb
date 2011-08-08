require 'rspec'
require 'cantango'
require 'fixtures/models'

# require 'cantango/configuration/engines/store_engine_shared'

class User
  include CanTango::Users::Masquerade

  attr_accessor :role

  include_and_extend SimpleRoles
end

CanTango.config.users.register :user, :admin


class UserRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  def permit_rules
    puts "permit roles for :user role"
    can :edit, Article
    cannot :edit, User
  end
end

class AdminRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  def permit_rules
    puts "permit roles for :admin role"
    can :edit, Article
    cannot :edit, User
  end
end


module CurrentUsers
  def current_user
    @current_user ||= ::User.new 'stan', 'stan@mail.ru', :role => 'user'
  end

  def current_admin
    @current_admin ||= ::User.new 'admin', 'admin@mail.ru', :role => 'admin'
  end
end

class Context
  include CanTango::Api::User::Can

  include ::CurrentUsers
  extend ::CurrentUsers
end

describe CanTango::Api::User::Can do
  subject { Context.new }

  describe 'user_ability' do
    specify { subject.user_ability(:user).should be_a CanTango::Ability }
    specify { subject.user_ability(:admin).should be_a CanTango::Ability }
  end

  describe 'current_ability :user' do
    specify { subject.current_ability(:user).should be_a CanTango::Ability }

    it 'should set the :user user correctly on ability' do
      subject.current_ability(:user).user.should == subject.current_user
    end
  end

  describe 'current_ability :admin' do
    specify { subject.current_ability(:admin).should be_a CanTango::Ability }

    it 'should set the :admin user correctly on ability' do
      subject.current_ability(:admin).user.should == subject.current_admin
    end
  end

  describe 'user' do
    specify { subject.current_user.role.should == 'user' }

    # user can edit Article, not Admin
    specify { subject.user_can?(:edit, Article).should be_true }
    specify { subject.user_can?(:edit, User).should be_false }

    specify { subject.user_cannot?(:edit, User).should be_true }
    specify { subject.user_cannot?(:edit, Article).should be_false }
  end

  describe 'admin' do
    specify { subject.current_admin.role.should == 'admin' }

    specify { subject.admin_can?(:edit, Article).should be_true }
    specify { subject.admin_can?(:edit, User).should be_true }

    specify { subject.admin_cannot?(:edit, User).should be_false }
    specify { subject.admin_cannot?(:edit, Article).should be_false }
  end

  describe 'admin masquerades as user' do
    before do
      Context.current_admin.masquerade_as Context.current_user
    end

    # admin masquerading as user can do same as user
    specify { subject.admin_can?(:edit, Article).should be_true }

    specify { subject.admin_can?(:edit, User).should be_false }

    specify { subject.admin_cannot?(:edit, User).should be_true }
    specify { subject.admin_cannot?(:edit, Article).should be_false }
  end
end

