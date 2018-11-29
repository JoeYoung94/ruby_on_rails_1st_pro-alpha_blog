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
      expect(page).to have_content 'Email is invalid'
    end

    it "can sign up with valid email address" do
      sign_up_with 'testhey', 'testhey@example.com', 'password'
      expect(page).to have_content 'Welcome'
      expect(page).to have_content('Log out')
    end

    it "cannot sign up with duplicated email address" do
      sign_up_with 'testnormal', 'testnormal@example.com', 'password'
      expect(page).to have_content 'Email has already been taken'
    end

    it "cannot sign up with duplicated user name" do
      sign_up_with 'normal_user', 'testnormal@example1.com', 'password'
      expect(page).to have_content 'Username has already been taken'
    end

    it "cannot sign up with too short username" do
      sign_up_with 'j', 'testnormal@example1.com', 'password'
      expect(page).to have_content 'Username is too short (minimum is 3 characters)'
    end

    it "cannot sign up with too long username" do
      too_long = 'this username is too long long long long long long long long long long'
      sign_up_with(too_long , 'testnormal@example1.com', 'password')
      expect(page).to have_content 'Username is too long (maximum is 25 characters)'
    end

    it "can go to see articles list when signup failed" do
      sign_up_with('j' , 'testnormal@example1.com', 'password')
      expect(page).to have_content 'Username is too short (minimum is 3 characters)'
      click_on_link 'Return to Ariticles list'
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

def click_on_link(link_name)
  click_link(link_name)
end
