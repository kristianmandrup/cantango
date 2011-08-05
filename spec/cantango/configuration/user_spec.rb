require 'rspec'
require 'cantango'
require 'fixtures/models'

describe CanTango::Configuration::User do
  describe 'default settings' do
    subject { CanTango::Configuration.user }

    describe 'default settings' do
      its(:relations)         { should_not be_empty }
      its(:unique_key_field)  { should == :email }
    end
  end
end


