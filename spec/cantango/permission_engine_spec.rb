require 'rspec'
require 'cantango'
require 'fixtures/models'
require 'cantango/rspec'

def config_folder
  File.dirname(__FILE__)+ "/../fixtures/config/"
end

CanTango.configure do |config|
  config.clear!

  config.engines.all :off
  config.engine(:permission).set :on

  config.ability.mode = :no_cache
  config.engine(:permission) do |engine|
    engine.mode = :no_cache
    engine.config_path(config_folder)
  end
  config.debug!
end

describe CanTango::PermissionEngine do
  context 'no-cache' do
    let (:ability) do
      CanTango::Ability.new @user
    end

    before do
      @user = User.new 'kris'
    end

    subject { CanTango::PermissionEngine.new ability }

    specify { CanTango.config.ability.modes.should include(:no_cache) }
    specify { subject.cached?.should be_false }

    describe '#execute!' do
      before do
        subject.execute!
      end

      it 'ability should have rules' do
        subject.send(:rules).should_not be_empty
      end

      it 'cache should be empty' do
          subject.cache.empty?.should be_true
      end
    end
  end
end


