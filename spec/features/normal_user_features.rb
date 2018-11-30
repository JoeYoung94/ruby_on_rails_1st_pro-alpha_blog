# spec for normak user features
require 'rails_helper'

describe "normal user operations", type: :feature do
  setup do  # this is the regiestered user
    normal_user = FactoryGirl.create(:user)
    normal_user.username = 'normal_user'
    normal_user.email = 'testnormal@example.com'
    normal_user.password = 'password'
    normal_user.admin = false
    normal_user.save

    # this is the setup for category for user choosing
    category1 = FactoryGirl.create(:category)
    category2 = FactoryGirl.create(:category)
    category1.name = 'category1'
    category2.name = 'category2'
    category1.save
    category2.save
  end

  context 'normal user article operations' do

    it "sign in with valid email and password" do
      sign_in_with 'testnormal@example.com', 'password'
      expect(page).to have_content 'Welcome'
    end

    it "sign in with valid email and invalid password" do
      sign_in_with 'testnormal@example.com', 'wrongpwd'
      expect(page).to have_content 'There are somgthing wrong with your login information'
    end

    it "can view all articles after logging in" do
      sign_in_with 'testnormal@example.com', 'password'
      visit articles_path
      expect(page).to have_content 'List of Articles'
    end

    it "can create a new article" do
      sign_in_with 'testnormal@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      create_article_with 'test article', 'this is the test description', ['category1']
      expect(page).to have_content 'Article was successfully created...'
    end

    it "can create a new article with multiple categories" do
      sign_in_with 'testnormal@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      create_article_with 'test article', 'this is the test description', ['category1', 'category2']
      expect(page).to have_content 'Article was successfully created...'
    end

    it "cannot create a new article with invalid title " do
      sign_in_with 'testnormal@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      create_article_with 'a', 'this is the test description', ['category1']
      expect(page).to have_content 'Title is too short (minimum is 3 characters)'
    end

    it "cannot create a new article with invalid description" do
      sign_in_with 'testnormal@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      create_article_with 'test article', 'invalid', ['category1']
      expect(page).to have_content 'Description is too short (minimum is 10 characters)'
    end

    it "can create an article with category absent" do
      sign_in_with 'testnormal@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      fill_in 'Title', with: 'test title'
      fill_in 'Description', with: 'this is the test description'
      click_button 'Create Article'
      expect(page).to have_content 'Article was successfully created...'
    end

  end

  context 'normal user user operations' do
    it "can check all the bloggers" do
      sign_in_with 'testnormal@example.com', 'password'
      visit users_path
      expect(page).to have_content 'All Bloggers'
      expect(page).to have_content 'normal_user'
    end
  end

  context 'normal user category operations' do
    it "can check all the categories" do
      sign_in_with 'testnormal@example.com', 'password'
      visit '/categories'
      expect(page).to have_content 'Listing'
      expect(page).to have_content 'category2'
    end

    it "can see a created article under a specific category" do
      sign_in_with 'testnormal@example.com', 'password'
      visit new_article_path
      create_article_with 'test article', 'this is the description', ['category1']
      visit '/categories'
      expect(page).to have_content 'Listing'
      expect(page).to have_content '1 article'
    end

    it "can check a created article under a specific category" do
      sign_in_with 'testnormal@example.com', 'password'
      visit new_article_path
      create_article_with 'test article', 'this is the description', ['category1']
      visit '/categories'
      expect(page).to have_content 'Listing'
      within("#category1") do
        click_on_link 'category1'
      end
      expect(page).to have_content 'Category:category1'
    end
  end

  context 'normal user profile operations' do
    it "can check view user profile" do
      sign_in_with 'testnormal@example.com', 'password'
      expect(page).to have_content 'Profile'
      click_link 'Profile'
      click_link 'View profile'
      expect(page).to have_content 'Welcome to'
      expect(page).to have_content "articles"
    end

    it "can edit user profile" do
      sign_in_with 'testnormal@example.com', 'password'
      expect(page).to have_content 'Profile'
      click_link 'Profile'
      click_link 'Edit your profile'
      expect(page).to have_content "Username"
      within("#userform") do
        fill_in 'Username', with: "normal2"
        fill_in 'Email', with: "testnormal2@example.com"
        fill_in 'Password', with: "password2"
        click_button 'Update Account'
      end
      expect(page).to have_content "Your account was updated successfully"
    end
  end

end



private

def sign_in_with (email, password)
  visit login_path
  fill_in 'Email', with: email
  fill_in 'Password', with: password
  click_button 'Login'
end

def click_on_link(link_name)
  click_link(link_name)
end

def create_article_with(title, description, categories)
  fill_in 'Title', with: title
  fill_in 'Description', with: description
  categories.each do |category|
    check category
  end
  click_button 'Create Article'
end
