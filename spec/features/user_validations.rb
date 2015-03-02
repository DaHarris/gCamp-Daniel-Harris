require 'rails_helper'

describe 'User can see validations' do

  it 'can see signup validations' do

    visit '/'

    click_on "Sign up"

    click_on "Create User"

    expect(page).to have_content("Password can't be blank")
    expect(page).to have_content("First name can't be blank")
    expect(page).to have_content("Last name can't be blank")
    expect(page).to have_content("Email can't be blank")
  end

  it 'can see signin validations' do

    visit '/'

    click_on "Sign up"

    #filling out form for location
    fill_in "First name", with: "Dan"
    fill_in "Last name", with: "Harris"
    fill_in "Email", with: "bobth3bum@gmail.com"
    fill_in "Password", with: "my_pass"
    fill_in "Password confirmation", with: "my_pass"

    click_on "Create User"

    click_on "Sign in"

    click_on "Sign In"

    expect(page).to have_content("Unsuccessful login.")
  end
end
