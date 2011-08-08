require 'dummy_spec_helper'
require 'integration/performance/helpers/ability'
describe "CanTango::Ability performance" do

  before(:each) do
    @user = User.create! :name => 'stanislaw', :role => 'user', :email => 'stanislaw@mail.ru'
    Article.create!(:title => 'one')
  end

  context "With cache disabled" do

    describe 'Memory store' do
      before do
        CanTango.configure do |config|
          config.cache.set :off
        end
      end

      it "3 requests" do
        get '/login_user/stanislaw'
        puts "\n\nFirst Request with Rails autoloading of all CanTango(if running isolated)"
        get "/articles"
        puts "\n\nSecond Request (basic #initialize)"
        get "/articles"
        puts "\n\nThird Request"
        get "/articles"
      end
    end
  end

  context "With cache enabled" do

    describe 'Memory store' do
      before do
        CanTango.configure do |config|
          config.cache.set :on
          config.cache.store.default_type = :memory
        end
      end

      it "3 requests" do
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


