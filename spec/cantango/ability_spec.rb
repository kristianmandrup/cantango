require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/rspec'

def config_folder 
  File.dirname(__FILE__)+ "/../fixtures/config/"
end

CanTango.configure do |config|
  config.engines.permission :on
  config.engines.permission.config_path = config_folder
end

class AdminsRoleGroupPermit < CanTango::RoleGroupPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can(:read, Comment)
    can(:write, Article)
  end
end

describe CanTango::Ability do
  let (:user) do
    User.new 'kris', 'kris@gmail.com'
  end

  let (:user_account) do
    ua = UserAccount.new user, :roles => [:user], :role_groups => [:admins]
    user.account = ua
  end

  let (:ability) do
    CanTango::Ability.new user_account
  end

  subject { ability }
    specify { ability.should be_allowed_to(:read, Comment)}
    specify { ability.should be_allowed_to(:write, Article)}

    its(:user_account)  { should be_a(UserAccount) }
    its(:user)          { should be_a(User) }

    its(:permits)       { should_not be_empty }
    its(:roles)         { should_not be_empty }
    #its(:role_groups)   { should_not be_empty }
end
