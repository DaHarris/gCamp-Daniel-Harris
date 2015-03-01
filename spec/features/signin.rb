require 'rails_helper'

describe 'User can Signin' do

  before :each do
    # visit root
    visit '/'
    click_on "Users"

    # click on link to go to new location form
    click_on "New User"

    #filling out form for location
    fill_in "First name", with: "Dan"
    fill_in "Last name", with: "Harris"
    fill_in "Email", with: "bobth3bum@gmail.com"
    fill_in "Password", with: "my_pass"
    fill_in "Password confirmation", with: "my_pass"

    click_on "Create User"
  end

  it 'can signin' do
    click_on "Sign in"

    fill_in "Email", with: "bobth3bum@gmail.com"
    fill_in "Password", with: "my_pass"

    click_on "Sign In"

    expect(page).to have_content('Logged in as: Dan')
  end
end
