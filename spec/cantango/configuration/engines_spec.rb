require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'cantango/configuration/engines/engine_shared'

describe CanTango::Configuration::Engines do
  subject { CanTango.config.engines }

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

  describe 'all on' do
    subject { CanTango.config.engines }

    before do
      subject.all :on
    end

    specify do
      [:permits, :permissions, :cache].each do |engine|
        CanTango.config.send(engine).on?.should be_true
      end
    end
  end

  describe 'active' do
    its(:active) { should == [:permits] }
  end

  describe 'execution' do
    describe 'default settings' do
      its(:registered) { should include(:permits, :permissions) }
      its(:execution_order) { should == [:permissions, :permits] }
    end
  end
end


