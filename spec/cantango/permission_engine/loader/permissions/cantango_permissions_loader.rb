require 'rspec'
require 'cantango' 
$:.unshift File.dirname(__FILE__)
require 'shared'

describe 'Load Permissions file' do
  let (:file) do
    File.join(config_folder, 'cantango_permissions.yml')
  end

  let (:loader) { CanTango::PermissionEngine::Loader::Permissions.new file }

  it_behaves_like "Permissions Loader"

  it 'load roles permissions group' do
    loader.roles_permissions.admin.static_rules.can.manage.first.should == 'all'
  end

  it 'load role_groups permissions group' do
    loader.role_groups_permissions.bloggers.static_rules.can.read.first.should == 'Article'
  end

  it 'load licenses permissions group' do
    loader.licenses_permissions.editors.static_rules.can.manage.should == ['all']
  end

end
