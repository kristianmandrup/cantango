require 'rspec'
require 'cantango'
require 'simple_roles'
require 'fixtures/models'
require 'cantango/api/current_users'
# require 'cantango/configuration/engines/store_engine_shared'

CanTango.configure do |config|
  config.users.register :user, User
  config.users.register :admin, Admin

  config.cache_engine.set :off
  config.permit_engine.set :on
end

# puts "#{CanTango.config.users.registered_classes} : #{CanTango.config.users.registered}"

class User
  include CanTango::Users::Masquerade
  include_and_extend ::SimpleRoles
end

class Context
  include CanTango::Api::User::Ability
  include CanTango::Api::User::Scope

  include_and_extend ::CurrentUsers
end

describe CanTango::Api::User::Scope do
  subject { Context.new }

  describe 'scope_user' do
    before do
      subject.current_admin.masquerade_as subject.current_user
    end

    specify do
      subject.scope_user(:admin) do |user|
        user.should be_a CanTango::Ability::Scope
        user.ability.user.name.should == 'admin'
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
      subject.current_user.masquerade_as subject.current_admin
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



