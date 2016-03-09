require 'rails_helper'

RSpec.describe House, type: :model do
	let(:house) {House.new(name: 'home')}

	it 'is valid' do
		expect(house).to be_valid
	end

	it 'is not valid without name' do
		house.name = nil

		expect(house).to_not be_valid
	end

	it 'has houseusers' do
		expect(house).to have_many(:house_users)
	end

	it 'has many users thought houseusers' do
		expect(house).to have_many(:users).through(:house_users)
	end
end
