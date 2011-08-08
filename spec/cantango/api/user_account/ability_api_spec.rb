require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'cantango/configuration/engines/store_engine_shared'

CanTango.users.register :user, :admin

module CurrentUserAccounts
  def current_user
    ::UserAccount.new 'stan', 'stan@mail.ru'
  end

  def current_admin
    ::UserAccount..new 'admin', 'admin@mail.ru'
  end
end

class Context
  include CanTango::Api::UserAccount::Ability

  include CurrentUserAccounts
  extend CurrentUserAccounts
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



