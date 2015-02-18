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

    click_on "Projects"

    click_on "New Project"

    fill_in "Name", with: "yeah"

    click_on "Create Project"
    click_on "Projects"
  end

  it 'User can create projects' do
    expect(page).to have_content("yeah")
  end

  it 'User can edit projects' do
    click_on "yeah"
    click_on "Edit Project"
    fill_in "Name", with: "yerp"
    click_on "Update Project"
    expect(page).to have_content("yerp")
  end

  it 'User can view show page for project' do
    click_on "yeah"
    expect(page).to have_content("Edit Project")
  end

  it "User can delete project" do
    click_on "yeah"
    click_on "Delete"
    expect(page).to have_no_content("yeah")
  end
end