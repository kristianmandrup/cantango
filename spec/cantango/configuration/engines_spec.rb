require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration::Engines do
  describe 'default settings' do
    subject { CanTango::Configuration.engines }

    its(:permission?) { should be_true }
    its(:permit?) { should be_true }
  end

  describe 'Permisssion engine' do
    describe 'turn off' do
      before :each do
        CanTango::Configuration.engines.permission :off
      end

      subject { CanTango::Configuration.engines }
      its(:permission?).should be_false
      its(:permit?).should be_true
    end
  end

  describe 'Permit engine' do
    describe 'turn off' do
      before :each do
        CanTango::Configuration.engines.permission :on
        CanTango::Configuration.engines.permit :off
      end

      subject { CanTango::Configuration.engines }
      its(:permission?).should be_true
      its(:permit?).should be_false
    end
  end

  describe 'Permisssion engine' do
    describe 'turn on' do
      before :each do
        CanTango::Configuration.engines.permit :off
        CanTango::Configuration.engines.permission :on
      end

      subject { CanTango::Configuration.engines }
      its(:permission?).should be_true
      its(:permit?).should be_false
    end
  end

  describe 'Permit engine' do
    describe 'turn on' do
      before :each do
        CanTango::Configuration.engines.permission :off
        CanTango::Configuration.engines.permit :on
      end

      subject { CanTango::Configuration.engines }
      its(:permission?).should be_false
      its(:permit?).should be_true
    end
  end
end


