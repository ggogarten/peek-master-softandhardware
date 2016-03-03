class House < ActiveRecord::Base
	validates :name, presence: true

	has_many :house_users
	has_many :users, through: :house_users
	has_many :pictures
end
