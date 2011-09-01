require 'rspec'
require 'cantango'

require 'cantango/configuration/engines/store_engine_shared'

describe CanTango::Configuration::Engines::Cache do

  it_should_behave_like 'Store Engine' do
    subject { CanTango.config.cache_engine }
  end

  it_should_behave_like 'Store' do
    subject { CanTango.config.cache_engine.store }
  end
end




