class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true


	has_many :house_users
	has_many :houses, through: :house_users
	has_secure_password

	has_many :pictures
end
