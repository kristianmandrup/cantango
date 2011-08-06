require 'cantango/configuration/engines/store_shared'

shared_examples_for 'Store Engine' do
  describe 'access' do
    it 'should access store' do
      subject.store.should be_a(CanTango::Configuration::Engines::Store)
    end

    it 'should have block dsl' do
      subject.store do |store|
        store.should be_a(CanTango::Configuration::Engines::Store)
      end
    end
  end
end

