class PicturesController < ApplicationController

	def upload
		@picture = Picture.new
	end

  def show
  end

	def create
		user = User.find(params[:user_id])
		house = House.find(params[:house_id])

		if params[:picture][:image]
			params[:picture][:image].each do |image|
				@picture = user.pictures.build(image: image)
				@picture.house_id = house.id
				@picture.save
				person = @picture.user.first_name + " " + @picture.user.last_name
				house_name = @picture.house.name
				url = @picture.image.url
				Picture.enroll(url, person, house_name)
			end
			p 'picture saved'
			redirect_to root_path
		else
			p 'picture didnt save'
		end
	end

	def matchPage
		@picture = Picture.new
	end

  def destroy
    @picture = Picture.find(params[:id])
    @picture.destroy
    redirect_to root_path
  end

	def match
		respond_to do |format|
			format.html do
				user = User.find(params[:user_id])
				house = House.find(params[:house_id])
				if params[:picture][:image][0]
					@picture = user.pictures.build(image: params[:picture][:image][0])
					@picture.house_id = house.id
					@picture.save
					url = @picture.image.url
					house_name = @picture.house.name
					number = current_user.phone_number
					Picture.recognize(url, house_name)
		    	redirect_to root_path
		    end
		  end
			format.json do
				user = current_user
				house = House.find_by_name(params[:name])
				if params[:image]
					binding.pry
					@picture = user.pictures.build(image: params[:image])
				end
			end
		end
	end

  def remove_subject
		user = User.find(params[:user_id])
		house = House.find(params[:house_id])
		if params[:picture][:image][0]
			@picture = user.pictures.build(image: params[:picture][:image][0])
			@picture.house_id = house.id
      person = @picture.user.first_name + " " + @picture.user.last_name
			house_name = @picture.house.name
			Picture.remove_subject(person, house_name)
    	redirect_to root_path
    end
	end


	def lock
		lock = 'lock'
		Picture.text(lock)
		redirect_to root_path
	end

  private

  def pic_params
  	params.require(:picture).permit(:image)
  end
end
