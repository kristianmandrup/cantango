require 'dummy_spec_helper'

Stamper.turn :off

describe "Caching of the rules" do
  
  before(:all) do
    @user = User.create! :name => 'stanislaw', :role => 'user', :email => 'stanislaw@mail.ru'
    Article.create!(:title => 'one')
  end

  context 'Moneta store' do
    before do
      CanTango.configure do |config|
        config.cache.store.default_class = CanTango::Ability::Cache::MonetaCache
      end
    end

    it "should just response" do
      get root_path
      response.status.should be(200)
    end

    it "should populate session with cache_key" do
      get '/login_user/stanislaw'
      session[:cache_key].should be_nil
      get '/articles'
      session[:cache_key].should_not be_nil
    end

    context "current Ability" do
      it "should have #cached_rules equal to #rules" do
        get '/login_user/stanislaw'
        get '/articles'
        #puts response.body
        response.body.should match(/Cached the rules!/)
        response.body.should match(/Using cached rules: false/)
        get '/articles'
        response.body.should match(/Cached the rules!/)
        response.body.should match(/Using cached rules: true/)
        #puts response.body
      end
    end
  end
end
