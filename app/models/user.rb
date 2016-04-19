class User < ActiveRecord::Base
  has_secure_password

  validates :firstname, presence: true
  validates :email, presence: true, uniqueness: true
  validates_confirmation_of :password
end