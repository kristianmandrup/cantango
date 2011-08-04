require 'dummy_spec_helper'

feature "Articles", %q{
  In order to have an awesome blog
  As an admin masquerading as a user
  I want to read and edit articles
  but not be able to create articles
} do

  background do
    Article.create!(:title => 'One')
    Article.create!(:title => 'Two')
   end

  scenario "Article index" do
    visit '/articles/admin'
    page.should have_content('One')
    page.should_not have_content('New article')
    #page.should have_content('Edit')
  end
end

