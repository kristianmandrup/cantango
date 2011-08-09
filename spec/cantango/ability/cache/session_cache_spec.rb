require 'rspec'
require 'cantango'

describe CanTango::Ability::Cache::SessionCache do
  subject { CanTango::Ability::Cache::SessionCache.new :roles }
    its(:name) { should == :roles}
    its(:rules) { should be_nil}
end

