require 'active_record/spec_helper'

require_all File.dirname(__FILE__) + "/../shared/" 

describe 'Scenario: users - :guest, :user, :admin' do
  context 'Admin User' do
    before(:all) do
      @user = User.create!(:role => "admin")
    end

    it_should_behave_like "Admin role" do
      let(:current_admin) { @user }
      let(:user) { current_ability(:admin) }
      let(:own_article) { Article.create!(:user_id => @user.id) }
      let(:own_post)    { Post.create(:user_id => @user.id) }
      let(:own_comment) { Comment.create(:user_id => @user.id) }
    end
  end
end
