require 'spec_helper'

class Menu
end

def WaiterRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def permit_rules
    can :read, Menu
    cannot :write, Menu
  end
end

def ChefRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def permit_rules
    can :publish, Menu
    can :write, Menu
  end
end

describe CanTango::Configuration::Debug do
  subject { CanTango.config.debug }

  describe 'should set debug mode :on' do
    before do
      subject.set :on
    end

    its(:on?) { should be_true }
    its(:off?) { should be_false }
  end

  describe 'should set debug mode :off' do
    before do
      subject.set :on
    end

    its(:on?) { should be_true }
    its(:off?) { should be_false }
  end

  context 'debug :on' do
    let (:user) do
      User.new 'kris', 'kris@gmail.com', :roles => [:waiter]
    end

    before do
      subject.set :on
      user_can? :read, Menu
    end

    describe 'should tell which permits allowe :read' do
      it 'should show WaiterRolePermit as the permit that allowed :read of Menu' do
        CanTango.config.permits.allowed(:read, Menu).should include(WaiterRolePermit)
      end
    end

    describe 'should tell which permits denied :write' do
      it 'should show WaiterRolePermit as the permit that denied :write of Menu' do
        CanTango.config.permits.denied(:write, Menu).should include(WaiterRolePermit)
      end
    end
  end
end



