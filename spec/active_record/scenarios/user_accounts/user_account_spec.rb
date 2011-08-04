require 'active_record/spec_helper'
require 'active_record/scenarios/user_accounts/helpers'

require_all File.dirname(__FILE__) + "/../shared"

describe 'Scenario: User account' do
  include UserFactory
  
  let(:user_profile) { create_user }
  let(:user_account) { create_user_account user_profile, :user }

  before(:each) do
    user_account = create_user_account user_profile, :user
    @user_profile = create_user
  end 

  context 'User profile' do
    it_should_behave_like "User role" do
      let(:user) { @user_profile }
      let(:own_article) { Article.create!(:user_id => @user_profile.id) }
      let(:own_post)    { Post.create(:user_id => @user_profile.id) }
      let(:own_comment) { Comment.create(:user_id => @user_profile.id) }
    end
  end

  context 'UserAccount himself' do
    it_should_behave_like "User role" do
      let(:user) { user_account }
      let(:own_article) { Article.create!(:user_id => @user_profile.id) }
      let(:own_post)    { Post.create(:user_id => @user_profile.id) }
      let(:own_comment) { Comment.create(:user_id => @user_profile.id) }
    end
  end
end


