require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration::Autoload do
  subject { CanTango.config.autoload }

  describe 'default settings' do
      its(:permits)     { should be_true }
      its(:models)      { should be_true }
  end

  describe 'permits' do
    describe 'turn off' do
      before do
        subject.permits :off
      end

      its(:permits)     { should be_false }
      its(:permits?)    { should be_false }
    end

    describe 'turn on' do
      before do
        subject.permits :on
      end

      its(:permits)     { should be_true }
      its(:permits?)    { should be_true }
    end
  end

  describe 'models' do
    describe 'turn off' do
      before do
        subject.models :off
      end

      its(:models)      { should be_false }
      its(:models?)     { should be_false }
    end

    describe 'turn on' do
      before do
        subject.models :on
      end

      its(:models)      { should be_true }
      its(:models?)     { should be_true }
    end
  end
end

