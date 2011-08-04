require 'rspec'
require 'cantango'

describe 'Permission store' do
  let (:permission_store) { CanTango.permission_store}
    its(:cache) { should_not be_nil}
end


