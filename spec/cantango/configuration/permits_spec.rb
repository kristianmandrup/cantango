require 'spec_helper'

class Menu
end

class WaiterRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def permit_rules
    can :read, Menu
    cannot :write, Menu
  end
end

class ChefRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def permit_rules
    can :publish, Menu
    can :write, Menu
  end
end

class Context
  include CanTango::Api::User::Ability
end

describe CanTango::Configuration::Permits do
  before do
    @permit_registry = CanTango::Configuration::Permits.instance
  end

  it "should treat missing methods as account keys" do
    @permit_registry.any_method.should be_kind_of(CanTango::Configuration::PermitRegistry)
  end

  describe 'debugging permits' do
    let(:context) { Context.new }
    let (:user) do
      User.new 'kris', 'kris@gmail.com', :role => :waiter
    end

    before do
      CanTango.config.debug.set :on
      context.user_ability(user).can? :read, Menu
    end

    describe 'should tell which permits allowe :read' do
      it 'should show WaiterRolePermit as the permit that allowed :read of Menu' do
        CanTango.permits_allowed(user, :read, Menu).should include(WaiterRolePermit)
      end
    end

    describe 'should tell which permits denied :write' do
      it 'should show WaiterRolePermit as the permit that denied :write of Menu' do
        CanTango.permits_denied(user, :write, Menu).should include(WaiterRolePermit)
      end
    end
  end
end



