require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'cantango/configuration/engine_shared'

describe CanTango::Configuration::Engines do
  describe 'Permission engine' do
 end

  describe 'Permit engine' do
    it_should_behave_like 'Engine' do
      let (:state) { :permit }
      subject { CanTango::Configuration.engines }
    end
  end

  describe 'Cache engine' do
    it_should_behave_like 'Engine' do
      let (:state) { :cache }
      subject { CanTango::Configuration.engines }
    end
  end
end


