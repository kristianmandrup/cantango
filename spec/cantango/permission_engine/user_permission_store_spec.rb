require 'rspec'
require 'cantango'

describe 'User permission store' do
  let (:user_permission_store) { CanTango.user_permission_store}
    its(:cache) { should_not be_nil}
end




