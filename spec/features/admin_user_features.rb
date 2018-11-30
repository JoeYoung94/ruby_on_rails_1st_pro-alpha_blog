
# spec for admin user features
require 'rails_helper'

describe "admin user operations", type: :feature do
  setup do  # this is the regiestered admin user
    admin_user = FactoryGirl.create(:user)
    admin_user.username = 'admin_user'
    admin_user.email = 'testadmin@example.com'
    admin_user.password = 'password'
    admin_user.admin = true
    admin_user.save

    # normal user
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

  context 'admin user articles operations' do
    it "sign in with valid email and password" do
      sign_in_with 'testadmin@example.com', 'password'
      expect(page).to have_content 'Welcome'
    end

    it "sign in with valid email and invalid password" do
      sign_in_with 'testadmin@example.com', 'wrongpwd'
      expect(page).to have_content 'There are somgthing wrong with your login information'
    end

    it "can view all articles after logging in" do
      sign_in_with 'testadmin@example.com', 'password'
      visit articles_path
      expect(page).to have_content 'List of Articles'
    end

    it "can create a new article" do
      sign_in_with 'testadmin@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      create_article_with 'test article', 'this is the test description', ['category1']
      expect(page).to have_content 'Article was successfully created...'
    end

    it "can create a new article with multiple categories" do
      sign_in_with 'testadmin@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      create_article_with 'test article', 'this is the test description', ['category1', 'category2']
      expect(page).to have_content 'Article was successfully created...'
    end

    it "cannot create a new article with invalid title " do
      sign_in_with 'testadmin@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      create_article_with 'a', 'this is the test description', ['category1']
      expect(page).to have_content 'Title is too short (minimum is 3 characters)'
    end

    it "cannot create a new article with invalid description" do
      sign_in_with 'testadmin@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      create_article_with 'test article', 'invalid', ['category1']
      expect(page).to have_content 'Description is too short (minimum is 10 characters)'
    end

    it "can create an article with category absent" do
      sign_in_with 'testadmin@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      fill_in 'Title', with: 'test title'
      fill_in 'Description', with: 'this is the test description'
      click_button 'Create Article'
      expect(page).to have_content 'Article was successfully created...'
    end

    it "can edit other user's article" do
      # first normal user creates an article
      sign_in_with 'testnormal@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      create_article_with 'test article', 'this is the test description created by normal user', ['category1']
      expect(page).to have_content 'Article was successfully created...'
      sign_in_with 'testadmin@example.com', 'password'
      visit articles_path
      expect(page).to have_content 'List of Articles'
      expect(page).to have_content 'test article'
      expect(page).to have_content 'Created by: normal_user'
      expect(page).to have_content 'Edit this article'
      within('#article1') do
        click_on_link "Edit this article"
      end
      expect(page).to have_content "Edit Existing Article"
      update_article_with "test article", "this description is modified by admin user", ['category1', 'category2']
      expect(page).to have_content 'Article was successfully updated'
    end

    it "can delete other user's article" do
      # first normal user creates an article
      sign_in_with 'testnormal@example.com', 'password'
      visit new_article_path
      expect(page).to have_content 'Create an article'
      create_article_with 'test article', 'this is the test description created by normal user', ['category1']
      expect(page).to have_content 'Article was successfully created...'
      sign_in_with 'testadmin@example.com', 'password'
      visit articles_path
      expect(page).to have_content 'List of Articles'
      expect(page).to have_content 'test article'
      expect(page).to have_content 'Created by: normal_user'
      expect(page).to have_content 'Edit this article'
      within('#article1') do
        click_on_link "Delete this article"
      end
      expect(page).to have_content "Article was successfully deleted"

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

def update_article_with(title, description, categories)
  fill_in 'Title', with: title
  fill_in 'Description', with: description
  categories.each do |category|
    check category
  end
  click_button 'Update Article'
end
