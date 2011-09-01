require 'spec_helper'
require 'fixtures/models'

class UserRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def dynamic_rules
    can(:read, Post) if $test == true
  end
end

class AdminRolePermit < CanTango::RolePermit
  def initialize ability
    super
  end

  protected

  def static_rules
  end
  def dynamic_rules
    can(:read, Article) do |article|
      $test == true
    end
  end
end

describe CanTango::Permits::RolePermit do
  let (:user) do
    User.new 'kris'
  end
  let (:user_account) do
    ua = UserAccount.new user, :roles => [:admin, :user], :role_groups => []
    user.account = ua
  end
  let (:ability) do
    CanTango::Ability.new user_account
  end
  let (:permit) do
    AdminRolePermit.new ability
  end
  before(:each) do
    CanTango.configure do |config|
      config.permit_engine.set :on
      config.permission_engine.set :off
    end
  end

  describe 'Having some dynamic conditions based on global things' do
    it "shoud react if global thing changed" do
      pending
      $test = true
      ability.can?(:read, Article.new).should == true
      $test = false
      ability.can?(:read, Article.new).should == false
    end
  end
  
  describe 'Having some dynamic conditions based on global things' do
    it "shoud react if global thing changed" do
      pending "Need to reveal CanCan's situation and caching"
      #$test = true
      #ability.can?(:read, Post.new).should == true
      #$test = false
      #ability.can?(:read, Post.new).should == false
    end
  end

end
