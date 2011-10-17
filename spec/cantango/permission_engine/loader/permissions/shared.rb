def config_folder 
  File.join(File.dirname(__FILE__), "/../../../../fixtures/config/")
end 

shared_examples_for "Permissions Loader" do
  it "should load a permission file" do
    loader.permissions.should_not be_empty
  end
end
