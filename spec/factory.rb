FactoryGirl.define do

  factory :user do
    first_name "dan"
    last_name "harris"
    email "dan@harris.com"
    password "password"
    admin true
  end

  factory :project do
    name "project test"
  end

  factory :task do
    description "task test"
    completed false
    association :project, factory: :project
  end

end
