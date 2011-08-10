require 'rspec'
require 'cantango'

require 'cantango/configuration/shared/factory_ex'

class MyFactory
  include CanTango::Configuration::Factory 
  include Singleton
end

describe CanTango::Configuration::Factory do
  subject { MyFactory.instance }

  specify { lambda { subject.default_factory}.should raise_error }

  it_should_behave_like 'Factory' do
  end
end


