require 'rails_helper'
describe "the signup process", type: :feature do
  it "signin with non admin user" do
    visit '/signup'
    fill_in 'Username', with: 'testNov19'
    fill_in 'Email', with: 'testnov19@example.com'
    fill_in 'Password', with: 'password'
    click_button 'Sign up'
    expect(page).to have_content 'Welcome'
  end
end
