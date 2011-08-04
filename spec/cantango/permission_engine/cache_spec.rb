require 'rspec'
require 'cantango'

describe CanTango::PermissionEngine::Cache do
  subject { CanTango::PermissionEngine::Cache.new :roles }
    its(:name) { should == :roles}
    its(:rules) { should be_nil}
end
