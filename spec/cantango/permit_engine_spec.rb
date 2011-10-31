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

describe CanTango::PermitEngine do
  before do
    @user = User.new 'kris'
  end

  describe 'UserAc engine' do
    let (:ability) do
      CanTango::Ability.new @user
    end
    subject { CanTango::PermitEngine.new ability }

    describe '#execute!' do
      before do
        subject.execute!
      end

      specify { subject.ability.send(:rules).should_not be_empty }
    end
  end
end


