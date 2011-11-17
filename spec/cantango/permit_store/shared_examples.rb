require 'spec_helper'
shared_examples_for "Having permissions" do
  it 'should contain bloggers permission allowing to read Comments' do
    store.role_groups_permissions['bloggers'].static_rules.can.read.should include('Article')
  end
 
  it 'should contain editors permission allowing to write Posts' do
    store.role_groups_permissions['editors'].static_rules.cannot.write.should include('Post')
  end
end

shared_examples_for "Having compiled permissions" do
  it 'should contain bloggers permission allowing to read Comments' do
    store.role_groups_rules.bloggers.can.should == %|can(:read, Article)\ncan(:read, Comment)|
  end
 
  it 'should contain editors permission allowing to write Posts' do
    store.role_groups_rules.editors.cannot.should == %|cannot(:write, Article)\ncannot(:write, Post)|
  end
end


