require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'path_helper'

describe CanTango::Configuration::Engines::Permission do
  describe 'default settings' do
    subject { CanTango::Configuration.engines.permission }
      it 'should not have config path' do
        lambda { subject.config_path }.should raise_error
      end
  end

  describe 'config_path' do
    subject { CanTango::Configuration.engines.permission }

    let(:yml_path) { File.join dummy_root_path, 'config' }

    before do
      subject.config_path yml_path
    end

    its(:config_path) { should == yml_path }
  end
end



