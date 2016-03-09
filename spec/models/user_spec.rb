require 'rails_helper'

RSpec.describe User, type: :model do
	let(:user) {User.new(username: 'nsellek', email: 'ngsellek@gmail.com', password: '12345', password_confirmation: '12345')}

  it 'is valid' do
  	expect(user).to be_valid
  end

  it 'is not valid without username' do
  	user.username = nil

  	expect(user).to_not be_valid
  end

  it 'is not valid without email' do
  	user.email = nil

  	expect(user).to_not be_valid
  end

  it 'has houseusers' do
  	expect(user).to have_many(:house_users)
  end

  it 'has many houses through houseusers' do
  	expect(user).to have_many(:houses).through(:house_users)
  end

  it 'has a secure password' do
    expect(user).to have_secure_password
  end
end
