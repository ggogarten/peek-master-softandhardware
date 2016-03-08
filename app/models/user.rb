class User < ActiveRecord::Base
  validates :first_name, presence: true
  validates :last_name, presence: true
	validates :email, presence: true, uniqueness: true
  validates :phone_number, presence: true, uniqueness: true


	has_many :house_users
	has_many :houses, through: :house_users

	has_secure_password

	has_many :pictures

	def get_or_create_api_key
		return api_key if api_key
		o = [('a'..'z'), ('A'..'Z'), ('0'..'9')].map { |i| i.to_a }.flatten
		key = (0...8).map { o[rand(o.length)] }.join
    self.update( api_key: key )
    return api_key
	end
end
