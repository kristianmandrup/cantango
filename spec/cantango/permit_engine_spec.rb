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
  config.engine(:permit) do |engine|
    engine.mode = :no_cache
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
  context 'no-cache' do
    before do
      @user = User.new 'kris'
    end

    describe 'Permit engine' do
      let (:ability) do
        CanTango::Ability.new @user
      end
      subject { CanTango::PermitEngine.new ability }

      describe '#execute!' do
        before do
          subject.execute!
        end

        it 'engine should have rules' do
          subject.send(:rules).should_not be_empty
        end

        it 'engine cache should be empty' do
          subject.cache.empty?.should be_true
        end
      end
    end
  end
end
