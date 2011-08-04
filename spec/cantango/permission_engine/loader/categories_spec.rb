require 'rspec'
require 'cantango'

def config_folder 
  File.dirname(__FILE__)+ "/../../../fixtures/config/"
end

describe 'Load Categories rules' do
  let (:file) do
    File.join(config_folder, 'categories.yml')
  end

  it "should load a categories file" do
    loader = CanTango::PermissionEngine::Loader::Categories.new file
    loader.categories_config.categories.should_not be_empty
    loader.categories_config.categories['articles'].should include('Article')
  end 
end
