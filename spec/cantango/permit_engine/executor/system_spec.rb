require 'spec_helper'

require 'cantango/rspec/matchers'
require 'fixtures/models'
require 'cantango/rspec/matchers'

class SystemRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, Article
    can :write, Post
    can :create, Comment
    :break
  end
end

describe CanTango::PermitEngine::Executor::System do
  let (:user) do
    User.new 'kris'
  end

  let (:user_account) do
    ua = UserAccount.new user
    user.account = ua
  end

  let (:ability) do
    @ability ||= CanTango::Ability.new user_account
  end

  let (:permit) do
    SystemRolePermit.new ability
  end

  let (:executor) do
    CanTango::PermitEngine::Executor::System.new permit
  end

  before(:each) do
    CanTango.config.permits.set :on
  end

  describe '#execute!' do
    before:each do
      CanTango.config.permits.set :on
    end

    describe 'should execute permit' do
      # specify { ability.should be_allowed_to(:read, Article) }
      # specify { ability.should be_allowed_to(:write, Post) }
      # specify { ability.should be_allowed_to(:create, Comment) }

      specify { lambda{ executor.execute! }.should_not raise_error }
    end
  end
end
