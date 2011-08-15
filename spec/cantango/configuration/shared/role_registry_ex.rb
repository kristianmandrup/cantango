require 'cantango/configuration/shared/registry_ex'

shared_examples_for 'Role Registry' do
  it_should_behave_like "Registry"

  describe 'default settings' do
    its(:has_method) { should == has }
    its(:list_method) { should == list }

    its(:default_has_method) { should be_a Symbol }
    its(:default_list_method) { should be_a Symbol }
  end

  describe "exclude" do
    before do
      subject.exclude :admin
    end

    its(:excluded) { should include(:admin) }
  end
end

