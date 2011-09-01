require 'spec_helper'

CanTango.config.adapters.use :compiler

describe CanTango::Ability::Cache::Reader do
  let (:session) do
    {}
  end

  let(:user) { User.new 'kris', 'kris@gmail.com' }

  let(:ability) { CanTango::Ability.new user, :session => session }

  let(:cache) { CanTango::Ability::Cache.new ability }

  subject do
    CanTango::Ability::Cache::Reader.new cache
  end

  specify { subject.should be_a CanTango::Ability::Cache::Reader }

  describe 'prepared rules' do
    before do
      $b = [:a,:b,:c]
      @condition_block = Proc.new { |arg| $b = [1, 2, 3, arg] } 
      @rules = [CanCan::Rule.new(true, :read, :all, nil, @condition_block) ]

      subject.expects(:loaded_rules).returns(@rules)
    end

    specify do
      subject.prepared_rules.should == @rules
    end

    it 'should have proc condition block' do
      $b = nil
      @rules.first.block.call(4)
      $b.should == [1,2,3,4]
    end
  end
end

