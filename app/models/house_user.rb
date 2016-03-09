class HouseUser < ActiveRecord::Base
	validates :house_id, presence: true
	validates :user_id, presence: true

  belongs_to :house
  belongs_to :user
end
