require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_url
    expect(page).to have_content("plz enter infos to creat user")
  end

  feature 'signing up a user' do

    scenario 'shows username on the homepage after signup' do
      visit new_user_url
      fill_in("username", with: "tk")
      click_on 'submit plz'
      expect(page).to have_content("tk")
    end

  end
end

feature 'logging in' do
  scenario 'shows username on the homepage after login' do
    visit new_user_url
    fill_in("username", with: "tk")
    click_on 'submit plz'
    visit new_session_url
    fill_in("username", with: "tk")
    click_on "plz let in"
    expect(page).to have_content("tk")
  end

end

feature 'logging out' do
  scenario 'begins with a logged out state' do
    visit users_url
    expect(page).to have_no_content("Username")
  end

  scenario 'doesn\'t show username on the homepage after logout' do
    visit users_url
    expect(page).to have_no_content("Username")
  end

end
