require 'rails_helper'
require 'factory'

RSpec.describe UsersController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
  end

  it "Creates a User with #Post" do
    expect(User.last.email).to eq("dan@harris.com")
  end

  it "Updates a user with #Patch" do
    put :update, {
      :id => @user.id,
      :user => {
        first_name: "big",
        last_name: "d"
      }
    }
    @user.reload
    expect(@user.first_name).to eq("big")
    expect(@user.last_name).to eq("d")
  end

  it 'Deletes a task' do
    total = User.all.count
    delete :destroy, {
      :id => @user.id
    }
    expect(User.all.count).to eq(total-1)
  end

end
