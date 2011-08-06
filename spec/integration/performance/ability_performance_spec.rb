require 'dummy_spec_helper'
require 'integration/performance/helpers/ability'
describe "CanTango::Ability performance" do

  before(:each) do
    @user = User.create! :name => 'stanislaw', :role => 'user', :email => 'stanislaw@mail.ru'
    Article.create!(:title => 'one')
  end

  context "With Caching disabled" do

    describe 'Memory store' do
      before do
        CanTango.configure do |config|
          config.cache.set :off
        end
      end

      it "should have #cached_rules equal to #rules" do
        get '/login_user/stanislaw'
        puts "\n\nFirst Request"
        get "/articles"
        puts "\n\nSecond Request"
        get "/articles"
        puts "\n\nThird Request"
        get "/articles"
      end
    end
  end

  context "Ability's rules" do

    describe 'Memory store' do
      before do
        CanTango.configure do |config|
          config.cache.set :on
          config.cache.store.default_type = :memory
        end
      end

      it "should have #cached_rules equal to #rules" do
        get '/login_user/stanislaw'
        puts "\n\nFirst Request"
        get "/articles"
        puts "\n\nSecond Request"
        get "/articles"
        puts "\n\nThird Request"
        get "/articles"
      end
    end
  end


end
