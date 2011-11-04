require 'active_record/spec_helper'

require_all File.dirname(__FILE__) + "/../shared/" 

describe 'Scenario: users - :guest, :user, :admin' do
  context 'User having both user and editor roles (normal user)' do
    before(:each) do
      @user = User.create!(:role => "user, editor")
    end

    it_should_behave_like "User + Editor roles" do
      let(:current_user) { @user }
      let(:user) { current_user_ability(:user) }
      let(:own_article) { Article.create!(:user_id => @user.id) }
      let(:own_post)    { Post.create(:user_id => @user.id) }
      let(:own_comment) { Comment.create(:user_id => @user.id) }
    end
  end
end
