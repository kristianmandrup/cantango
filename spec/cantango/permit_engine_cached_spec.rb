require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/rspec'

def config_folder
  File.dirname(__FILE__)+ "/../fixtures/config/"
end

CanTango.configure do |config|
  config.clear!
  config.ability.mode = :cache
  config.engine(:permit) do |engine|
    engine.mode = :cache
  end
  config.debug!
end

class UserPermit < CanTango::UserPermit
  def initialize ability
    super
  end

  protected

  def static_rules
    can :read, Article
  end
end

describe CanTango::PermitEngine do
  context 'cache' do
    before do
      @user = User.new 'kris'
    end

    let (:ability) do
      CanTango::CachedAbility.new @user
    end
    subject { CanTango::PermitEngine.new ability }

    describe '#execute!' do
      before do
        subject.execute!
      end

      it 'engine should have rules' do
        subject.send(:rules).should_not be_empty
      end

      it 'engine cache should have rules' do
        subject.cache.empty?.should be_false
      end
    end
  end
end
