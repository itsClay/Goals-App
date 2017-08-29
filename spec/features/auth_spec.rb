
require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  before :each do
    visit new_user_url

  end

  scenario 'has New User on the page' do
    expect(page).to have_content 'New User'
    save_and_open_page
  end

  scenario 'takes a username and password' do
    expect(page).to have_content 'Username'
    expect(page).to have_content 'Password'
  end

  scenario 'redirects to all users index and displays usernames on success' do
    fill_in 'Username', with: 'Filbert'
    fill_in 'Password', with: '123456'
    click_button 'Create Account'
    expect(page).to have_content 'Filbert'
    expect(current_path).to eq(users_path)
  end

  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do

    end

  end
end

# feature 'logging in' do
#   scenario 'shows username on the homepage after login'
#
# end
#
# feature 'logging out' do
#   scenario 'begins with a logged out state'
#
#   scenario 'doesn\'t show username on the homepage after logout'
#
# end
