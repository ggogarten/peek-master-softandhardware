require 'rails_helper'

RSpec.describe HouseUser, type: :model do
	let(:houseuser) {HouseUser.new(house_id: 1, user_id: 3)}

	it 'is valid' do
		expect(houseuser).to be_valid
	end

	it 'is not valid without house_id' do
		houseuser.house_id = nil

		expect(houseuser).to_not be_valid
	end

	it 'is not valid without user_id' do
		houseuser.user_id = nil

		expect(houseuser).to_not be_valid
	end

	it 'has users' do
		expect(houseuser).to belong_to(:user)
	end

	it 'has houses' do
		expect(houseuser).to belong_to(:house)
	end
end
