require 'rspec'
require 'cantango'
require 'fixtures/models'

# require 'cantango/configuration/engines/store_engine_shared'

CanTango.users.register :user, :admin

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

class Context
  include CanTango::Api::User::Can

  include ::CurrentUsers
  extend ::CurrentUsers
end

describe CanTango::Api::User::Can do
  subject { Context.new }

  describe 'user' do
    # user can edit Article, not Admin
    specify do
      subject.user_can?(:edit, Article).should be_true
      subject.user_can?(:edit, Admin).should be_false

      subject.user_cannot?(:edit, Admin).should be_true
      subject.user_cannot?(:edit, Article).should be_false
    end
  end

  describe 'admin_user' do
    specify do
      subject.admin_can?(:edit, Article).should be_true
      subject.admin_can?(:edit, Admin).should be_true

      subject.admin_cannot?(:edit, Admin).should be_false
      subject.admin_cannot?(:edit, Article).should be_false
    end
  end

  describe 'admin masquerades as user' do
    before do
      Context.current_admin.masquerade_as Context.current_user
    end

    # admin masquerading as user can do same as user
    specify do
      subject.admin_can?(:edit, Article).should be_true
      subject.admin_can?(:edit, Admin).should be_false

      subject.admin_cannot?(:edit, Admin).should be_true
      subject.admin_cannot?(:edit, Article).should be_false
    end
  end
end

