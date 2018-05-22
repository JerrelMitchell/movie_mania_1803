class User < ApplicationRecord
  validates :username, uniqueness: true, presence: true
  validates_presence_of :password, require: true, uniqueness: true
  # validates_presence_of :is_admin, require: false

  has_secure_password
end
