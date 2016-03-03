class HousesController < ApplicationController
	before_filter :authorize

	def new
		@house = House.new
	end

	def show
		@house = House.find(params[:id])
	end

	def create
		user = User.find(params[:user_id])
		@house = user.houses.build(house_params)

		respond_to do |format|
			if @house.save
				HouseUser.create(house_id: @house.id, user_id: current_user.id)
				format.html {redirect_to root_path, notice: 'House made'}
			else
				format.html {render :new}
			end
		end
	end

	private

	def house_params
		params.require(:house).permit(:name)
	end
end
