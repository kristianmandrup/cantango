require 'rspec'
require 'cantango'

require 'cantango/configuration/engines/store_engine_shared'

CanTango.users.register :user, :admin

class Context
  include CanTango::Api::User::Ability 

  def current_user
    User.new 'stan', 'stan@mail.ru'
  end

  def current_admin
    User.new 'admin', 'admin@mail.ru'
  end  
end

describe CanTango::Api::User::Ability do
  subject { Context.new }

  describe 'user_ability' do
    specify { subject.user_ability(:user).should be_a CanTango::Ability }

    specify { subject.user_ability(:admin).should be_a CanTango::Ability }
  end

  describe 'current_ability' do
    specify { subject.current_ability(:user).should be_a CanTango::Ability }
    specify { subject.current_ability(:admin).should be_a CanTango::Ability }
  end  
end


