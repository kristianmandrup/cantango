require 'rspec'
require 'cantango'

describe CanTango::Ability::Cache::SessionCache do
  subject { CanTango::Ability::Cache::SessionCache.new :roles, :session => {} }
    its(:name)  { should == :roles}
    its(:store) { should_not be_nil}
    its(:store) { should be_a CanTango::Cache::HashCache }

end

