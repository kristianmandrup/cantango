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

    describe 'relations' do
      before do
        subject.relations = [:mine]
      end
      its(:relations)         { should include(:mine) }
    end

    describe 'unique_key_field' do
      before do
        subject.unique_key_field = :username
      end
      its(:unique_key_field)         { should == :username }
    end
  end
end


