require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'cantango/configuration/engines/store_engine_shared'
require 'path_helper'

describe CanTango::Configuration::Engines::Permission do
  subject { CanTango::Configuration.engine(:permission) }

  describe 'default settings' do
    it 'should not have config path' do
      lambda { subject.config_path }.should raise_error
    end
  end

  it_should_behave_like 'Store Engine' do
    subject { CanTango::Configuration.engine(:permission) }
  end

  it_should_behave_like 'Store' do
    subject { CanTango::Configuration.engine(:permission).store }
  end

  describe 'config_path' do
    let(:yml_path) { File.join dummy_root_path, 'config' }

    before do
      subject.config_path yml_path
    end

    its(:config_path) { should == yml_path }
  end
end



