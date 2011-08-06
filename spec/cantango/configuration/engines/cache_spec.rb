require 'rspec'
require 'cantango'
require 'fixtures/models'

require 'cantango/configuration/engines/store_engine_shared'

describe CanTango::Configuration::Engines::Cache do

  it_should_behave_like 'Store Engine' do
    subject { CanTango::Configuration.engine(:cache) }
  end

  it_should_behave_like 'Store' do
    subject { CanTango::Configuration.engine(:cache).store }
  end
end




