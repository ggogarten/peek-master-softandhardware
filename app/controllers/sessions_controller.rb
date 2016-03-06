class SessionsController < ApplicationController
	
  def new
  end

  def create
  	user = User.find_by_email(params[:email]) || redirect_to('/login')

    respond_to do |format|
    	if user.authenticate(params[:password])
        format.html do 
          session[:user_id] = user.id
          redirect_to '/'
        end

        format.json do
          user.get_or_create_api_key
          render json: {success: true, extras: {userProfileModel: user, sessionId: user.api_key}}
        end	
      else
      	format.html { redirect_to '/login' }
        format.json { render json: {success: false, extras: {errors: user.errors.full_messages}}}
      end
    end
  end

  def destroy
   session[:user_id] = nil
   user.update(api_key: nil)
   redirect_to '/login'
 end
end
