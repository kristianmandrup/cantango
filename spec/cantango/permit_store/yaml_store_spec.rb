$:.unshift(File.dirname(__FILE__))
require 'rspec'
require 'cantango'
require 'fixtures/tango_fixtures'
require 'fixtures/models/user'
require 'fixtures/models/items'
require 'shared_examples'

def config_folder 
  File.dirname(__FILE__)+ "/../../fixtures/config/"
end

describe CanTango::PermissionEngine::YamlStore do
  include CanTangoFixtures
  let (:permissions) { tango_permissions }

  context 'Loading permissions' do
    let (:store) do
      @store ||= CanTango::PermissionEngine::YamlStore.new 'permissions', :path => config_folder 
    end

    before(:each) do
      store.load!
    end

    it_should_behave_like "Having permissions"
  end

  context 'Caching permissions by types' do
    let (:store) do
      @store ||= CanTango::PermissionEngine::YamlStore.new 'permissions', :path => config_folder 
    end

    before(:each) do
      store.load!
    end

    context "user_types" do
      subject{ @store.user_types_rules }
      it { should == @store.user_types_compiled_permissions }
    end

    context "account_types" do
      subject{ @store.account_types_rules }
      it { should == @store.account_types_compiled_permissions }
    end

    context "roles" do
      subject{ @store.roles_rules }
      it { should == @store.roles_compiled_permissions }
    end

    context "role groups" do
      subject{ @store.role_groups_rules }
      it { should == @store.role_groups_compiled_permissions }
    end

    context "licenses" do
      subject{ @store.licenses_rules }
      it { should == @store.licenses_compiled_permissions }
    end

    it_should_behave_like "Having compiled permissions"
  end

  context 'Saving permissions' do
    let (:store) do
      @store ||= CanTango::PermissionEngine::YamlStore.new :test_permissions, :path => config_folder 
    end

    before(:each) do
      store.save! permissions
      store.load!
    end

    it_should_behave_like "Having permissions" 
  end

  context 'Loading permissions and saving them again' do
    let (:store) do
      @store ||= CanTango::PermissionEngine::YamlStore.new :test_permissions, :path => config_folder 
    end

    before(:each) do
      store.load!
      store.save!
      store.load!
    end

    it_should_behave_like "Having permissions"
  end
end
