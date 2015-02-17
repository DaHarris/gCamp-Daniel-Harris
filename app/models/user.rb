class User < ActiveRecord::Base
  validates :first_name, :last_name, :email, presence: true
  validate :email, uniqueness: true

end
