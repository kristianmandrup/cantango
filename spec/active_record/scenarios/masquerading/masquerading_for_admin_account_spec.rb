require 'active_record/spec_helper'
require 'active_record/scenarios/user_accounts/helpers'

require_all File.dirname(__FILE__) + "/../shared/" 

describe 'Scenario: masquerading for admin account' do
  include UserFactory

  let(:user_profile) { @u ||= User.create(:name => 'kris', :role => 'user') }
  let(:admin_account) { create_user_account user_profile, :admin }

  context "Masquerading as user" do 
    before(:each) do
      admin_account.masquerade_as user_profile
    end

    it_should_behave_like "User role" do
      let(:current_admin) { admin_account }
      let(:user) { current_user_ability(:admin) }
      let(:own_article) { Article.create!(:user_id => user_profile.id) }
      let(:own_post)    { Post.create(:user_id => user_profile.id) }
      let(:own_comment) { Comment.create(:user_id => user_profile.id) }
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
      let(:user) { current_user_ability(:user) }
      let(:own_article) { Article.create!(:user_id => @user.id) }
      let(:own_post)    { Post.create(:user_id => @user.id) }
      let(:own_comment) { Comment.create(:user_id => @user.id) }
    end
  end
end
