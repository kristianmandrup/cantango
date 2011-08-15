require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/rspec'

def config_folder 
  File.dirname(__FILE__)+ "/../fixtures/config/"
end

CanTango.configure do |config|
  config.clear!
  # config.permissions.set :on
  config.engines.all :on

  config.permissions.config_path = config_folder
  config.categories.register :blog_items => [Article, Post]
end

class AdminsRoleGroupPermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :write, category(:blog_items)
    cannot :write, Post
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


describe CanTango::Ability do
  let (:user) do
    User.new 'krisy', 'krisy@gmail.com'
  end

  let (:user_account) do
    ua = UserAccount.new user, :roles => [:user, :admin], :role_groups => [:admins]
    user.account = ua
  end

  before do
    CanTango.config.clear!
    @ability = CanTango::Ability.new user_account
  end

  specify { CanTango.config.roles.excluded.should be_empty }
  specify { CanTango.config.role_groups.excluded.should be_empty }

  subject { @ability }
    specify { @ability.should be_allowed_to(:read, Comment) }
    specify { @ability.should be_allowed_to(:write, Article) }
    specify { @ability.should_not be_allowed_to(:write, Post) }

    its(:user_account)  { should be_a(UserAccount) }
    its(:user)          { should be_a(User) }

    its(:permits)       { should_not be_empty }
    its(:roles)         { should_not be_empty }
    its(:role_groups)   { should_not be_empty }
end
