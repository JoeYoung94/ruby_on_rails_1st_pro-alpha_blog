require 'rails_helper'
describe "user login and check general things", type: :feature do
  context 'signup and then do all operations' do
    it "signup a new user with valid email and password" do
      sign_up_with 'testNov19', 'testnov19@example.com', 'password'
      expect(page).to have_content 'Welcome'
      expect(page).to have_content('Log out')
    end

    it "signed up and then log out" do
      sign_up_with 'testNov19', 'testnov19@example.com', 'password'
      click_link 'Log out'
      expect(page).to have_content 'logged out'
    end

    it "signed up and then check articles" do
      sign_up_with 'testNov19', 'testnov19@example.com', 'password'
      sign_in_with 'testnov19@example', 'password'
      visit '/articles'
      click_on_link 'Alpha Blog'
      expect(page).to have_content 'List of Articles'
    end

    it "signed up and sign in with invalid email address" do
      sign_up_with 'testNov19', 'testnov19@example.com', 'password'
      sign_in_with 'testnov', 'pa'
      expect(page).to have_content 'There are somgthing wrong with your login information'
    end



    it "signed in and then check all users" do
      sign_up_with 'testNov19', 'testnov19@example.com', 'password'
      sign_in_with 'testnov19@example', 'password'
      visit root_path
      click_on_link 'users'
      expect(page).to have_content 'All Bloggers'
    end

    it "signed in and then check all articles" do
      sign_up_with 'testNov19', 'testnov19@example.com', 'password'
      sign_in_with 'testnov19@example', 'password'
      visit root_path
      click_on_link 'Articles'
      expect(page).to have_content 'List of Articles'
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
