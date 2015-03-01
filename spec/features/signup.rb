require 'rails_helper'

describe 'User can Signup and Crud User registration' do

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

  it 'Can create user' do
    expect(page).to have_content("Dan")
  end

  it 'Can edit user' do
    click_on "Edit"

    fill_in "First name", with: "Daniel"
    fill_in "Password", with: "my_pass"
    fill_in "Password confirmation", with: "my_pass"

    click_on "Update User"

    expect(page).to have_content("Daniel")
  end

  it 'Can view user show page' do
    click_on "Dan"

    expect(page).to have_content("First Name")
  end

  it 'Can delete user' do
    click_on "Delete"

    expect(page).to have_no_content("Dan")
  end
end
