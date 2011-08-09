require 'rspec'
require 'cantango'

class BaseAccount
  def initialize
  end
end


describe CanTango::Configuration::UserAccount do
  before do
    CanTango.config.user.base_class = User
  end

  subject { CanTango.config.user_account }

  describe 'set base class' do
    before do
      subject.base_class = BaseAccount
    end

    its(:base_class) { should == BaseAccount }
  end
end


