class User < ActiveRecord::Base
  has_secure_password
  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  has_many :memberships, dependent: :destroy
  has_many :projects, through: :memberships
  has_many :comments, dependent: :nullify

  def project_member(user)
    self.projects.each do |pro|
      pro.memberships.each do |x|
        if user.id == x.user_id
          return true
        end
      end
    end
    return false
  end

  def full_name
    "#{first_name} #{last_name}"
  end

end
