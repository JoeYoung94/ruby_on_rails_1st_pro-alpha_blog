# feature test for new user operations which contains:
  #sign up process
    #sign up with invalid email format
    #sign up with duplicated email address
    #sign up with duplicated username
    #sign up with valid email and password

require 'rails_helper'
describe "user login and check general things", type: :feature do
  setup do  # this is the regiestered user
    normal_user = FactoryGirl.create(:user)
    normal_user.username = 'normal_user'
    normal_user.email = 'testnormal@example.com'
    normal_user.password = 'password'
    normal_user.admin = false
    normal_user.save
  end

  context 'new user sign up features' do
    it "click on sign up now should go to the sign up page" do
      visit root_path
      click_on_link 'Sign up now!'
      expect(page).to have_content 'Sign up for Alpha Blog'
    end

    it "cannot sign up with invalid email address" do
      sign_up_with 'invalid_username', 'invalid_email', 'password'
      expect(page).to have_content 'Return to Ariticles list'
    end

    it "can sign up with valid email address" do
      sign_up_with 'testhey', 'testhey@example.com', 'password'
      expect(page).to have_content 'Welcome'
      expect(page).to have_content('Log out')
    end

    it "cannot sign up with duplicated email address" do
      sign_up_with 'testnormal', 'testnormal@example.com', 'password'
      expect(page). to have_content 'Email has already been taken'
    end

    it "cannot sign up with duplicated user name" do
      sign_up_with 'normal_user', 'testnormal@example1.com', 'password'
      expect(page). to have_content 'Username has already been taken'
    end


  end

end

private
def sign_up_with (username, email, password)
  visit '/signup'
  fill_in 'Username', with: username
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Sign up'
end

def sign_in_with (email, password)
  visit login_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Login'
end

def click_on_link(link_name)
  click_link(link_name)
end
