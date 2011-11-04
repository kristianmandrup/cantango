require 'rspec'
require 'cantango'
require 'simple_roles'
require 'fixtures/models'
require 'cantango/api/current_users'
# require 'cantango/configuration/engines/store_engine_shared'

class User
  include_and_extend SimpleRoles
end

class Admin < User
end

CanTango.configure do |config|
  config.users.register :user, User
  config.users.register :admin, Admin

  config.cache_engine.set :off
  config.permit_engine.set :on
end

class Context
  include CanTango::Api::User::Ability

  include_and_extend ::CurrentUsers
end

describe CanTango::Api::User::Ability do
  subject { Context.new }

  describe 'user_ability user' do
    specify { subject.user_ability(subject.current_user).should be_a CanTango::Ability }
  end

  describe 'user_ability admin' do
    specify { subject.user_ability(subject.current_admin).should be_a CanTango::Ability }
  end

  describe 'current_user_ability :user' do
    specify { subject.current_user_ability(:user).should be_a CanTango::Ability }

    it 'should set the :user user correctly on ability' do
      subject.current_user_ability(:user).user.should == subject.current_user
    end
  end

  describe 'current_user_ability :admin' do
    specify { subject.current_user_ability(:admin).should be_a CanTango::Ability }

    it 'should set the :admin user correctly on ability' do
      subject.current_user_ability(:admin).user.should == subject.current_admin
    end
  end
end


