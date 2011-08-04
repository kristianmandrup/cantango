require 'active_record/spec_helper'

require_all File.dirname(__FILE__) + "/../shared/" 

describe 'Scenario: users - :guest, :user, :admin' do
  context 'User user (normal user)' do
    before(:each) do
      @user = User.create!(:role => "user")
      @own_todo = Todo.create!
      @own_todo.authors << @user
      @own_todo.save!

    end
  
    it_should_behave_like "User role" do
      let(:current_user) { @user }
      let(:user) { current_ability(:user) }
      let(:own_article) { Article.create!(:user_id => @user.id) }
      let(:own_post)    { Post.create(:user_id => @user.id) }
      let(:own_comment) { Comment.create(:user_id => @user.id) }
      let(:own_todo) { @own_todo }
    end
 
    it "should allow :write of own Todos" do
      @user.should be_allowed_to(:write, @own_todo)
    end

    it "should not allow :write of not-own Todos" do
      @user.should_not be_allowed_to(:write, Todo.new)
    end
  end
end
