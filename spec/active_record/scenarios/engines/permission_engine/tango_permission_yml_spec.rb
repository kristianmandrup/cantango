require 'active_record/spec_helper'
require_all File.dirname(__FILE__) + "/../../shared/" 

describe 'Cantango config: permissions.yml' do

  before(:each) {
    CanTango.configure do |config|
      config.permit_engine.set :off
      config.permission_engine.config_path = File.dirname(__FILE__)
      config.permission_engine.set :on
    end
    @user ||= User.create!(:email => "kris@gmail.com", :role => 'musician')
    @own_todo = Todo.create!
    @own_todo.authors << @user
    @own_todo.save!
  }

  after(:each) { 
    CanTango.configure do |config|
      config.permit_engine.set :on
      config.permission_engine.set :off
    end
  }

  let(:current_user) { @user }
  let(:ability) { current_user_ability(:user) }
  let(:own_comment) { Comment.create(:user_id => @user.id) }
  let(:specific_post) { Post.create(:body => "Nice!") }

  context ":users group testing" do
    it "should be allowed to read Comment" do
      ability.should be_allowed_to(:read, Comment)
    end
  
    it "should be allowed to write own Comment" do
      ability.should be_allowed_to(:write, own_comment)
    end
    
    it "should be not be allowed to write not-own Comment" do
      ability.should_not be_allowed_to(:write, Comment.new)
    end

    it "should be allowed to write Post with :body => 'Nice!'" do
      ability.should be_allowed_to(:write, specific_post)
    end

    it "should not be allowed to write Post except specific_post" do
      ability.should_not be_allowed_to(:write, Post.new)
    end

  end

  context "various musical rules to ensure that all rules are evaluated" do
    it "should contain rules for musician role" do
      ability.should be_allowed_to(:read, Song)
      ability.should be_allowed_to(:read, Concerto)
      ability.should be_allowed_to(:create, Tune)
      ability.should be_allowed_to(:write, Song)
      ability.should be_allowed_to(:manage, Improvisation)
      ability.should_not be_allowed_to(:write, Concerto)
    end
  end

    it "should allow :write of own Todos" do
      @user.should be_allowed_to(:write, @own_todo)
    end

    it "should not allow :write of not-own Todos" do
      @user.should_not be_allowed_to(:write, Todo.new)
    end


end

CanTango.config.permission_engine.set :off
CanTango.config.permit_engine.set :on
