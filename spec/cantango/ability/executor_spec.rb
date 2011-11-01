require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/rspec'

def config_folder
  File.dirname(__FILE__)+ "/../fixtures/config/"
end

CanTango.configure do |config|
  config.clear!
  config.ability.mode = :no_cache
end

class MyExecutor
  include CanTango::Ability::Executor

  attr_reader :ability

  def initialize ability
    @ability = ability
  end

  def valid?
    true
  end

  def cache_key
    :my_exec
  end

  def permit_rules
    ability.permit_rules
  end
end

module CanTango
  class Ability
    def permit_rules
      can :edit, Project
    end
  end
end

describe CanTango::Ability::Executor do
  context 'no-cache' do
    let (:ability) do
      CanTango::Ability.new @user
    end

    before do
      @user = User.new 'kris'
    end

    subject { MyExecutor.new ability }

    describe '#execute!' do
      before do
        subject.execute!
      end

      specify { subject.ability.send(:rules).should_not be_empty }
    end
  end
end


