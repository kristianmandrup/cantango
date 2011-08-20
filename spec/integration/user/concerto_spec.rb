require 'dummy_spec_helper'

feature "Concertos", %q{
  In order to have an awesome musical pages 
  As an user having role_groups 'composers'
  I want to do something with concertos (According to role_groups)
} do

  background do
    Concerto.create!(:title => 'one')
    Concerto.create!(:title => 'two')

    @composer = Admin.create!(:name => 'composer', :role_groups => 'composers', :email => 'stanislaw@mail.ru')
    @musician = User.create! :name => 'musician', :role_groups => 'musicians', :email => 'editor@mail.ru'
  end

  scenario "Concerto index" do
    visit '/concertos'
    page.should have_content('one')
    page.should have_content('two')
  end

  scenario "Show concerto to composer" do
    visit '/login_user/composer'

    visit '/concertos/one' # using friendly id :)
    page.should have_content('one')
    visit '/concertos/two'
    page.should have_content('two')
  end

  scenario "Show concerto to musician" do
    visit '/login_user/musician'

    visit '/concertos/one' # using friendly id :)
    page.should have_content('one')
    #page.should have_content('two')
  end
end
