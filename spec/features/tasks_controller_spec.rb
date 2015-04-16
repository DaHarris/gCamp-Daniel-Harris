require 'rails_helper'
require 'factory'

RSpec.describe TasksController, type: :controller do

  before :each do
    @user = FactoryGirl.create(:user)
    session[:user_id] = @user.id
    @project = FactoryGirl.create(:project)
    @task = FactoryGirl.create(:task)
  end

  it "Creates a task with #Post" do
    expect(Task.last.description).to eq("task test")
  end

  it "Updates a task with #Patch" do
    put :update, {
      :project_id => @project.id,
      :id => @task.id,
      :task => {
        description: "updated"
      }
    }
    @task.reload
    expect(@task.description).to eq("updated")
  end

  it 'Deletes a task' do
    total = Task.all.count
    delete :destroy, {
      :project_id => @project.id,
      :id => @task.id
    }
    expect(Task.all.count).to eq(total-1)
  end

end
