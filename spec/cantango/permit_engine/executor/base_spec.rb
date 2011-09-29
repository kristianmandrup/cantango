require 'spec_helper'

require 'cantango/rspec/matchers'
require 'fixtures/models'
require 'cantango/rspec/matchers'

class CustomerRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def permit_rules
    can :read, Article
  end
end

class SimpleUser
  attr_accessor :roles_list

  def initialize
    @roles_list = [:customer]
  end

  def role_groups_list
    []
  end
end

describe CanTango::PermitEngine::Executor::Base do
  let (:user) do
    SimpleUser.new
  end

  let (:ability) do
    @ability ||= CanTango::Ability.new user
  end

  let (:permit) do
    CustomerRolePermit.new ability
  end

  let (:executor) do
    CanTango::PermitEngine::Executor::Base.new permit
  end

  before(:each) do
    CanTango.config.permits.set :on
  end

  describe '#execute!' do
    before:each do
      CanTango.config.permits.set :on
    end

    describe 'should find permit based on #roles_list' do
      specify { lambda{ executor.execute! }.should_not raise_error }
    end

    describe 'should search permit based on #role_groups_list' do
      before do
        user.roles_list.clear
      end
      specify { lambda{ executor.execute! }.should_not raise_error }
    end
  end
end
