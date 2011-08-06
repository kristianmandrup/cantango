require 'rspec'
require 'cantango'

class BaseAccount
  def initialize
  end
end


describe CanTango::Configuration::Account do
  subject { CanTango::Configuration.account }

  describe 'default settings' do
    its(:base_class)        { should be_nil }
  end

  describe 'set base class' do
    before do
      subject.base_class = BaseAccount
    end

    its(:base_class) { should == BaseAccount }
  end
end


