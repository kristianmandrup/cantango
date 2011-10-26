require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/rspec'

def config_folder
  File.dirname(__FILE__)+ "/../fixtures/config/"
end

CanTango.configure do |config|
  config.clear!
end

class AdminPermit < CanTango::UserPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, Article
  end

  module Cached
    def permit_rules
      can :edit, Article
    end
  end
end


describe CanTango::AbilityExecutor do
  before do
    @user = User.new 'kris', :roles => [:admin]
    @abil = CanTango::AbilityExecutor.new @user 
  end

  subject { CanTango::AbilityExecutor.new @user }

  describe 'cached rules' do
    its(:cached_rules) { should_not be_empty }
  end

  describe 'cached rules' do
    its(:non_cached_rules) { should_not be_empty }
  end

  describe 'rules' do
    its(:rules) { should include(@abil.cached_rules) }
    its(:rules) { should include(@abil.non_cached_rules) }
  end
end
