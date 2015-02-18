require 'rails_helper'

describe 'User can CRUD Events' do

  before :each do
    # visit root
    visit '/'
    click_on "Users"

    # click on link to go to new location form
    click_on "New User"

    #filling out form for location
    fill_in 'user[first_name]', :with => "Dan"
    fill_in 'user[last_name]', :with => "Harris"
    fill_in 'user[email]', :with => "bobth3bum@gmail.com"
    fill_in 'user[password]', with: "my_pass"
    fill_in 'user[password_confirmation]', with: "my_pass"

    click_on "Create User"

    click_on "Sign in"

    fill_in 'email', :with => "bobth3bum@gmail.com"
    fill_in 'password', :with => "my_pass"

    click_on "Signin"
    

    #submitting form to create a location
    click_on "Create Location"

    click_on 'Add Event'

    fill_in 'event[description]', :with => 'Dinner Party'
    fill_in 'event[date]', :with => '01/01/2015'
    check 'event[requires_id]'

    click_on 'Create Event'
  end
