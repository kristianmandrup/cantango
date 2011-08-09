require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'cantango/configuration/engines/engine_shared'

describe CanTango::Configuration::Engines do
  describe 'Permission engine' do
    it_should_behave_like 'Engine' do
      subject { CanTango.config.engine(:permission) }
    end
  end

  describe 'Permit engine' do
    it_should_behave_like 'Engine' do
      subject { CanTango.config.engine(:permit) }
    end
  end

  describe 'Cache engine' do
    it_should_behave_like 'Engine' do
      subject { CanTango.config.engine(:cache) }
    end
  end
end


