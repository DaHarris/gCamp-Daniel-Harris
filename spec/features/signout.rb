require 'rails_helper'

describe 'User can Signin' do

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

  end

  it 'can signout' do
    click_on "Sign out"
    expect(page).to have_content("Logged out.")
  end

  it 'redirects correctly' do
    click_on "Sign out"
    current_path.should == '/'
  end
end
