require 'devise-dummy_spec_helper'

module DeviseSessionHelpers
  def login_with email, password
    fill_in       "Email",    :with => email
    fill_in       "Password", :with => password
    click_button  "Sign in"
  end

  def login_musician
    visit user_session_path
    login_with 'musician@mail.ru', "secret123"
  end

  def login_composer
    visit admin_session_path
    login_with 'stanislaw@mail.ru', "admin123"
  end
end

feature "Concertos", %q{
  In order to have an awesome musical pages 
  As an user having role_groups 'composers'
  I want to do something with concertos (According to role_groups)
} do

  background do
    Concerto.create!(:title => 'one')
    Concerto.create!(:title => 'two')

    Admin.delete_all
    User.delete_all

    @composer = Admin.create! :name => 'composer', :role_groups => 'composers', :email => 'stanislaw@mail.ru', :password => 'admin123', :confirmation_password => 'admin123'
    @musician = User.create! :name => 'musician', :role_groups => 'musicians', :email => 'musician@mail.ru', :password => 'secret123', :confirmation_password => 'secret123'

    Capybara.reset_sessions!
  end

  include DeviseSessionHelpers
=begin
  scenario "Show concerto index without login - fallback to Guest user", :js => true do
    visit '/concertos'
    page.should have_content('one')
    page.should have_content('two')
  end

  scenario "Show concerto index to musician", :js => true do
    pending
    login_musician
    # save_and_open_page

    visit '/concertos'
    page.should have_content('one')
    page.should have_content('two')
  end

  scenario "Show concerto to musician" do
    pending

    login_musician

    visit '/concertos/one' # using friendly id :)
    page.should have_content('one')
    visit '/concertos/two'
    page.should have_content('two')
  end
=end
  scenario "Show concerto admin index to composer", :js => true do
    login_composer

    visit '/concertos/admin'
    # save_and_open_page

    puts page.body.inspect
    page.should have_content('one')
    page.should have_content('two')
  end
end

