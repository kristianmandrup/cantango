
require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/rspec'

CanTango.configure do |config|
  config.permissions.set :off
  config.permits.set :on
  config.categories.register :blog_items => [Article, Post]
end

class AdminsRoleGroupPermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :publish, Post
    can :write, Article
    can :write, category(:blog_items)
  end
end

class EditorsRoleGroupPermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :publish, category(:blog_items)
  end
end



class UserRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, Comment
  end
end

class AdminRolePermit < CanTango::RolePermit
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

    before do
      CanTango.config.roles.exclude :user
      CanTango.config.role_groups.exclude :admins
      CanTango.config.categories.register :blog_items => [Article, Post]

      @ability = CanTango::Ability.new user_account
    end

    after do
      CanTango.config.clear!
    end

    subject { @ability }
      its(:permit_class_names) { should include "AdminRolePermit" }

      specify { @ability.should be_allowed_to(:read, Post)}

      specify { @ability.should_not be_allowed_to(:read, Comment)}
      specify { @ability.should_not be_allowed_to(:write, Article)}
  end
end

describe CanTango::Ability do
  describe 'roles :only filter on' do
    let (:user) do
      User.new 'stan', 'stan@gmail.com'
    end

    let (:user_account) do
      ua = UserAccount.new user, :roles => [:user, :admin], :role_groups => [:admins, :editors]
      user.account = ua
    end

    before do
      CanTango.config.categories.register :blog_items => [Article, Post]
      CanTango.config.roles.only :user
      CanTango.config.role_groups.only :admins
      @ability = CanTango::Ability.new user_account
    end

    after do
      CanTango.config.clear!
    end

    subject { @ability }
      its(:permit_class_names) { should include("UserRolePermit", "AdminsRoleGroupPermit") }

      specify { @ability.should be_allowed_to(:read, Comment)}
      specify { @ability.should be_allowed_to(:publish, Post)}

      specify { @ability.should_not be_allowed_to(:publish, Article)}
   end
end
