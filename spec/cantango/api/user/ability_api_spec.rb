require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'cantango/configuration/engines/store_engine_shared'

CanTango.config.users.register :user, :admin

module CurrentUsers
  def current_user
    @cu ||= ::User.new 'stan', 'stan@mail.ru'
  end

  def current_admin
    @ca ||= ::User.new 'admin', 'admin@mail.ru'
  end
end

class Context
  include CanTango::Api::User::Ability

  include CurrentUsers
  extend ::CurrentUsers
end

describe CanTango::Api::User::Ability do
  subject { Context.new }

  describe 'user_ability :user' do
    specify { subject.user_ability(:user).should be_a CanTango::Ability }
  end

  describe 'user_ability :admin' do
    specify { subject.user_ability(:admin).should be_a CanTango::Ability }
  end

  describe 'current_ability :user' do
    specify { subject.current_ability(:user).should be_a CanTango::Ability }

    it 'should set the :user user correctly on ability' do
      subject.current_ability(:user).user.should == subject.current_user
    end
  end

  describe 'current_ability :admin' do
    specify { subject.current_ability(:admin).should be_a CanTango::Ability }

    it 'should set the :admin user correctly on ability' do
      subject.current_ability(:admin).user.should == subject.current_admin
    end
  end
end


