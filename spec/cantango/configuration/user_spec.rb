require 'rspec'
require 'cantango'
require 'fixtures/models'

class BaseUser
  def initialize
  end
end

describe CanTango::Configuration::User do
  before do
    CanTango.config.user.base_class = User
    CanTango.config.user_account.base_class = UserAccount
  end

  subject { CanTango.config.user }

  describe 'default settings' do
    its(:relations)         { should_not be_empty }
    its(:unique_key_field)  { should == :email }
    its(:base_class)        { should == ::User }
  end

  describe 'set base class' do
    before do
      subject.base_class = BaseUser
    end

    its(:base_class)        { should == BaseUser }
  end

  describe 'relations config' do
    before do
      subject.relations = :mine
    end
    its(:relations)         { should include(:mine) }
  end

  describe 'unique_key_field config' do
    before do
      subject.unique_key_field = :username
    end
    its(:unique_key_field)  { should == :username }
  end
end

