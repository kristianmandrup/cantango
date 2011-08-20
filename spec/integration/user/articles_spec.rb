require 'dummy_spec_helper'

feature "Articles", %q{
  In order to have an awesome blog
  As an author
  I want to create and manage articles
} do

  background do
    Article.create!(:title => 'one')
    Article.create!(:title => 'two')

    @user = User.create! :name => 'stanislaw', :role => 'user', :email => 'stanislaw@mail.ru'
    @editor = Admin.create! :name => 'editor', :role => 'editor', :email => 'editor@mail.ru'
  end

  scenario "Article index" do
    visit '/articles'
    page.should have_content('one')
    page.should have_content('two')
  end

  scenario "Show article to user stanislaw" do
    visit '/login_user/stanislaw'

    visit '/articles/one' # using friendly id :)
    page.should have_content('one')
    visit '/articles/two'
    page.should have_content('two')
  end

  scenario "Show article to editor" do
    visit '/login_user/editor'

    visit '/articles/one' # using friendly id :)
    page.should have_content('one')
    #page.should have_content('two')
  end
end
