require 'rails_helper'
require 'factory'

RSpec.describe ProjectsController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
    @project = FactoryGirl.create(:project)
  end

  it "Creates a project with #Post" do
    project_test = Project.first
    expect(project_test.name).to eq("project test")
  end

  it "Updates a project with #Patch" do
    put :update, {
      :id => @project.id,
      :project => {
        name: "updated"
      }
    }
    @project.reload
    expect(@project.name).to eq("updated")
  end

  it 'Deletes a project' do
    total = Project.all.count
    delete :destroy, :id => @project.id
    expect(Project.all.count).to eq(total-1)
  end

end
