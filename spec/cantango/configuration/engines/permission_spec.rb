require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'cantango/configuration/engines/store_engine_shared'
require 'path_helper'

describe CanTango::Configuration::Engines::Permission do
  subject { CanTango.config.permission_engine }

  it_should_behave_like 'Store Engine' do
    subject { CanTango.config.permission_engine }
  end

  it_should_behave_like 'Store' do
    subject { CanTango.config.permission_engine.store }
  end

  describe 'config_path' do
    let(:yml_path) { File.join dummy_root_path, 'config' }

    before do
      subject.config_path yml_path
    end

    its(:config_path) { should == yml_path }
  end
end



