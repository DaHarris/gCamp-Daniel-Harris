require 'rails_helper'

describe 'User can CRUD Events' do

  before :each do
    # visit root
    visit '/'
    click_on "Sign up"

    #filling out form for location
    fill_in "First name", with: "Dan"
    fill_in "Last name", with: "Harris"
    fill_in "Email", with: "bobth3bum@gmail.com"
    fill_in "Password", with: "my_pass"
    fill_in "Password confirmation", with: "my_pass"

    click_on "Create User"

    fill_in "Name", with: "yeah"

    click_on "Create Project"
    first(:link, "Projects").click

    first(:link, "yeah").click
    click_on "0 tasks"

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
    click_on ("delete")
    expect(page).to have_content("Task was successfully destroyed.")
  end
end
