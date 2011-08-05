require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration::Engines do
  describe 'Permission engine' do
    it_should_behave_like 'Engine' do
      let (:state) { :permission }
      subject { CanTango::Configuration.engines }
    end
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


