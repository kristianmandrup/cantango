require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'cantango/configuration/engines/engine_shared'

class InvalidPerformanceTool
end

class PerformanceTool
  attr_reader :ability

  def execute!
  end
end

describe CanTango::Configuration::Engines do
  subject { CanTango.config.engines }

  describe 'default settings' do
    describe 'default_available' do
      its(:default_available) { should include(:permission, :permit, :cache) }
    end

    describe 'available' do
      %w(permit permission).each do |engine|
        specify { subject.available?(engine).should be_true }
        specify { subject.available?(engine.to_sym).should be_true }
      end
    end

    specify { subject.registered.keys.should include(:permit, :permission) }

    describe 'active' do
      its(:active) { should == [:permit] }
    end

    describe 'execution_order' do
      its(:execution_order) { should == [:permission, :permit] }
    end
  end

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

  context 'all on' do
    subject { CanTango.config.engines }

    before do
      subject.all :on
    end

    specify do
      [:permits, :permissions, :cache].each do |engine|
        CanTango.config.send(engine).on?.should be_true
      end
    end

    describe 'active' do
      its(:active) { should include(:permit, :permission) }
    end
  end

  describe 'register' do
    describe 'invalid engine registration' do
      specify do
        lambda { subject.register :performance => InvalidPerformanceTool }.should raise_error 
      end
    end

    describe 'valid engine registration' do
      before do
        subject.register :performance => PerformanceTool
      end

      specify { subject.registered.keys.should include(:performance) }
    end
  end

  describe 'execution' do
    context 'reverse execution order' do
      before do
        subject.execution_order = :permit, :permission
      end

      its(:execution_order) { should == [:permit, :permission] }
    end

    describe 'execute_before' do
      before do
        subject.execute_before :permit, :non_existing
      end

      its(:execution_order) { should == [:non_existing, :permit, :permission] }
    end

    describe 'execute_after' do
      before do
        subject.execute_after :permit, :performance
        subject.execute_after :permission, :last
      end

      after do
        CanTango.config.engines.clear!
      end

      its(:execution_order) { should == [:non_existing, :permit, :performance, :permission, :last] }
    end
  end
end


