require 'rspec'
require 'cantango'
require 'fixtures/models'

class MoneyCache < CanTango::Ability::MonetaCache
  def initialize

  end
end

describe CanTango::Configuration::Engines::Cache do
  describe 'default settings' do
    subject { CanTango::Configuration.engines.cache }

    describe 'Store' do
      subject { CanTango::Configuration.engines.cache.store }

      describe 'default settings' do
          its(:default_type) { should be_a Symbol }
          its(:default) { should be_a Class }
          its(:options) { should be_empty }
      end

      describe 'default' do
        before do
          subject.default = MoneyCache
        end
        its(:default) { should be_a Class }
        its(:default) { should == MoneyCache }
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
  end
end




