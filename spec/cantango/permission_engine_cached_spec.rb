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
  config.ability.mode = :cache
  config.engine(:permission) do |engine|
    engine.mode = :cache
    engine.config_path(config_folder)
  end
  config.debug!
end

describe CanTango::PermissionEngine do
  context 'cache' do
    let (:ability) do
      CanTango::Ability.new @user
    end

    before do
      @user = User.new 'kris'
    end

    subject { CanTango::PermissionEngine.new ability }

    describe '#execute!' do
      before do
        subject.execute!
        puts subject.inspect
      end

      it 'engine should have rules' do
        subject.rules.should_not be_empty
      end

      it 'engine cache should be empty' do
          subject.cache.empty?.should_not be_true
      end
    end
  end
end



