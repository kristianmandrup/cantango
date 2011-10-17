require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/api/current_user_accounts'
# require 'cantango/configuration/engines/store_engine_shared'

class User
  include_and_extend SimpleRoles
end

CanTango.configure do |config|
  config.users.register     :user, User
  config.users.register     :admin, Admin

  config.user_accounts.register  :user, UserAccount
  config.user_accounts.register  :admin, AdminAccount

  config.cache_engine.set :off
  config.permit_engine.set :on
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

class Context
  include CanTango::Api::UserAccount::Can

  include_and_extend ::CurrentUserAccounts
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


