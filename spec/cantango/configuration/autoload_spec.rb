require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration::Autoload do
  describe 'default settings' do
    describe 'default settings' do
      subject { CanTango::Configuration.autoload }
        its(:permits)     { should be_true }
        its(:models)      { should be_true }
    end
  end
end

