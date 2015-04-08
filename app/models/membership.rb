class Membership < ActiveRecord::Base
  belongs_to :user
  belongs_to :project
  validates :user_id, presence: true
  validates :project_id, presence: true
  validate :check_unique, on: :create
  validate :ensure_owner, on: :update

  def ensure_owner
    if Membership.where(project_id: self.project_id, owner: true).count == 1 && owner == false
      errors.add(:base, "Projects must have at least one owner")
    end
  end

  def last_owner(project, user)
    if project.memberships.where(owner: true).count == 1 && self.owner == true
      return true
    else
      false
    end
  end

  private

  def check_unique
    if Membership.find_by(user_id: user_id, project_id: project_id)
      errors.add(:base, "User has already been added to this project")
    end
  end
end
