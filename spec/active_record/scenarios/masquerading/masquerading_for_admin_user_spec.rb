require 'active_record/spec_helper'

require_all File.dirname(__FILE__) + "/../shared/" 

describe 'Scenario: masquerading for admin user' do

  context "Masquerading as user" do
    before(:each) do
      @user = User.create!(:role => "user")
      @admin = Admin.create!(:name => "kris")
      @admin.masquerade_as @user
    end

    it_should_behave_like "User role" do
      let(:current_user) { @admin }
      let(:user) { current_ability(:user) }
      let(:own_article) { Article.create!(:user_id => @user.id) }
      let(:own_post)    { Post.create(:user_id => @user.id) }
      let(:own_comment) { Comment.create(:user_id => @user.id) }
    end
  end

  context "Masquerading as editor" do 
    before(:each) do
      @user = User.create!(:role => "editor")
      @admin = Admin.create!(:name => "kris")
      @admin.masquerade_as @user
    end

    it_should_behave_like "Editor role" do
      let(:current_user) { @admin }
      let(:user) { current_ability(:user) }
      let(:own_article) { Article.create!(:user_id => @user.id) }
      let(:own_post)    { Post.create(:user_id => @user.id) }
      let(:own_comment) { Comment.create(:user_id => @user.id) }
    end
  end
end
