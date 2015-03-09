class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user_id, presence: true
  validates :user_id, uniqueness: {message: " has already been added to this project"}

end
