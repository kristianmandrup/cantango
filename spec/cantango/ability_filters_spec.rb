
require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/rspec'

CanTango.configure do |config|
  config.permissions.set :off

  config.permits.set :on

  config.roles.exclude :user
  config.role_groups.exclude :admins
end

class AdminsRoleGroupPermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :write, Article
    can :write, category(:blog_items)
  end
end

class UserRolePermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, Comment
  end
end

class AdminRolePermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, Post
  end
end

describe CanTango::Ability do
  describe 'roles filter on' do
    let (:user) do
      User.new 'stan', 'stan@gmail.com'
    end

    let (:user_account) do
      ua = UserAccount.new user, :roles => [:user, :admin], :role_groups => [:admins]
      user.account = ua
    end

    let (:ability) do
      CanTango::Ability.new user_account
    end

    subject { ability }
      its(:permit_class_names) { should include "AdminRolePermit" }

      specify { ability.should be_allowed_to(:read, Post)}

      specify { ability.should_not be_allowed_to(:read, Comment)}
      specify { ability.should_not be_allowed_to(:write, Article)}
  end
end
