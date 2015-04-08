class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user_id, presence: true
  validates :project_id, presence: true
  validate :check_unique

  private

  def check_unique
    if Membership.find_by(user_id: user_id, project_id: project_id)
      errors.add(:base, "User has already been added to this project")
    end
  end
end
