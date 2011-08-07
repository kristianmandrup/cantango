require 'rspec'
require 'cantango'

require 'cantango/configuration/engines/store_engine_shared'

CanTango.users.register :user, :admin

class Context
  include CanTango::Api::User::Scope

  def current_user
    @current_user ||= User.new 'stan', 'stan@mail.ru'
  end

  def current_admin
    @current_admin ||= User.new 'admin', 'admin@mail.ru'
  end
end

describe CanTango::Api::User::Scope do
  subject { Context.new }

  describe 'scope_user' do
    before do
      Context.current_admin.masquerade_as Context.current_user
    end

    specify do
      subject.scope_user(:admin) do |user|
        user.should be_a CanTango::Ability::Scope
        user.ability.user.name.should == 'stan'
      end
    end

    specify do
      admin = subject.scope_user(:user)
      admin.should be_a CanTango::Ability::Scope
      admin.ability.user.name.should == 'stan'
    end
  end

  describe 'real_user' do
    before do
      Context.current_user.masquerade_as Context.current_admin
    end

    specify do
      subject.real_user(:user) do |user|
        user.should be_a CanTango::Ability::Scope
        user.ability.user.name.should == 'stan'
      end
    end

    specify do
      admin = subject.real_user(:admin)
      admin.should be_a CanTango::Ability::Scope
      admin.ability.user.name.should == 'admin'
    end
  end
end



