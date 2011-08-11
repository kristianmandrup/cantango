require 'rspec'
require 'cantango'

require 'cantango/configuration/shared/hash_registry_ex'

describe CanTango::Configuration::Categories::Category do
  subject { CanTango::Configuration::Categories::Category.new }
    specify { subject.has_any?(:x).should_not be_true }

  subject { CanTango::Configuration::Categories::Category.new :a, :b }
    specify { subject.has_any?(:a).should be_true }
end

describe CanTango::Configuration::Categories do
  subject { CanTango.config.categories }

  it_should_behave_like "Hash Registry"

  describe 'API' do
    before do
      categories = {'a' => ['B', 'C'], 'x' => ['Y', 'Z']}
      subject.register categories
   end

    describe 'category_has_subject?' do
      specify { subject.category('a').has_any?('B').should be_true }
    end

    describe 'has_subject?' do
      specify { subject.has_any?('Y').should be_true }
    end

    describe 'siblings_of_subject' do
      specify { subject.siblings_of_subject('B').should == ['B', 'C'] }

      specify { subject.siblings_of_subject('blip').should == nil }
    end

    describe 'category_of_subject' do
      specify { subject.category_name_of_subject('B').should == 'a' }

      specify { subject.category_name_of_subject('c').should == nil }
    end

    describe 'categories_of_subject' do
      specify do
        subject.categories_of_subject('B').should == {'a' => ['B', 'C']}
      end

      specify do
        subject.categories_of_subject('blip').should == {}
      end
    end
  end
end


