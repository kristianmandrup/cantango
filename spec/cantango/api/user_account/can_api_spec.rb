require 'rspec'
require 'cantango'
require 'fixtures/models'

# require 'cantango/configuration/engines/store_engine_shared'

class User

  attr_accessor :role

  include_and_extend SimpleRoles

end
CanTango.configure do |config|
  config.users.register     :user, :admin
  config.user_accounts.register  :user, :admin
  config.cache.set :off
  config.permits.set :on
end

class UserRolePermit < CanTango::RolePermit
  def permit_rules
    can :edit, Article
    cannot :edit, User
  end
end

class AdminRolePermit < CanTango::RolePermit
  def permit_rules
    can :edit, Article
    cannot :edit, User 
  end
end


class User
  include CanTango::Users::Masquerade
end


module CurrentUsers
  def current_user
    ::User.new 'stan', 'stan@mail.ru'
  end

  def current_admin
    ::User.new 'admin', 'admin@mail.ru'
  end
end

module CurrentUserAccounts
  def current_user_account
    ::UserAccount.new current_user, :roles => ['user']
  end

  def current_admin_account
    ::UserAccount.new current_admin, :roles => ['admin']
  end
end

class Context
  include CanTango::Api::UserAccount::Can

  include ::CurrentUsers
  include ::CurrentUserAccounts

  extend ::CurrentUsers
  extend ::CurrentUserAccounts
end

describe CanTango::Api::UserAccount::Can do
  subject { Context.new }

  describe 'user_account' do
    # user can edit Article, not Admin
    specify do
      subject.user_account_can?(:edit, Article).should be_true
      subject.user_account_can?(:edit, User).should be_false

      subject.user_account_cannot?(:edit, User).should be_true
      subject.user_account_cannot?(:edit, Article).should be_false
    end
  end

  describe 'admin_account' do
    specify do
      subject.admin_account_can?(:edit, Article).should be_true
      subject.admin_account_can?(:edit, User).should be_false

      subject.admin_account_cannot?(:edit, User).should be_true
      subject.admin_account_cannot?(:edit, Article).should be_false
    end
  end

  describe 'admin masquerades as user' do
    before do
      Context.current_admin.masquerade_as Context.current_user
    end

    # admin masquerading as user can do same as user
    specify do
      subject.admin_account_can?(:edit, Article).should be_true
      subject.admin_account_can?(:edit, User).should be_false

      subject.admin_account_cannot?(:edit, User).should be_true
      subject.admin_account_cannot?(:edit, Article).should be_false
    end
  end
end


