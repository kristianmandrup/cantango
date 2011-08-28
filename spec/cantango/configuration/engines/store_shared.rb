CanTango.config.adapters.adapter :moneta

class MoneyCache < CanTango::Ability::Cache::MonetaCache
  def initialize
  end
end


shared_examples_for 'Store' do
  describe 'default settings' do
    its(:default_type) { should be_a Symbol }
    its(:default_class) { should be_a Class }
    its(:options) { should_not be_nil }
  end

  describe 'default_class' do
    before do
      subject.default_class = MoneyCache
    end
    its(:default_class) { should be_a Class }
    its(:default_class) { should == MoneyCache }
  end

  describe 'options' do
    before do
      subject.options = {:type => :redis, :port => 3000}
    end
    its(:options) { should_not be_empty }
  end

  describe 'default_type' do
    before do
      subject.default_type = :redis
    end
    its(:default_type) { should == :redis }
  end
end

