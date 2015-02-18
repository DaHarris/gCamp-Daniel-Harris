require 'rails_helper'

describe 'User can CRUD Events' do

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

    click_on "Sign in"

    fill_in 'email', with: "bobth3bum@gmail.com"
    fill_in 'password', with: "my_pass"

    click_on "Sign In"

    click_on "Tasks"

    click_on "New Task"

    fill_in "Description", with: "dope"

    click_on "Create Task"
    first(:link, "Tasks").click
  end

  it 'User can create tasks' do
    expect(page).to have_content("dope")
  end

  it 'User can edit task' do
    click_on "Edit"
    fill_in "Description", with: "sure"
    click_on "Update Task"
    expect(page).to have_content("sure")
  end

  it 'User can see show page for tasks' do
    click_on "dope"
    expect(page).to have_content("dope")
  end

  it 'User can delete tasks' do
    click_on "Delete"
    expect(page).to have_no_content("dope")
  end
end
