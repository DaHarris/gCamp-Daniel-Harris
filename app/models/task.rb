class Task < ActiveRecord::Base
  validations :description, presence: true

end
