class SessionsController < ApplicationController

  def new
  end

  def create
  	user = User.find_by_email(params[:email]) || redirect_to('/login')

    respond_to do |format|
    	if user.authenticate(params[:password])
        format.html do
          session[:user_id] = user.id
          redirect_to dash_path
        end

        format.json do
          user.get_or_create_api_key
          render json: {success: true, extras: {userProfileModel: user, sessionId: user.api_key, houses: user.houses}}
        end
      else
      	format.html { redirect_to root_path }
        format.json { render json: {success: false, extras: {errors: user.errors.full_messages}}}
      end
    end
  end

  def destroy

    respond_to do |format|
      format.html do
        session[:user_id] = nil
        redirect_to root_path
      end

      format.json do
        user = User.find_by(api_key: params[:api_key])
        user.update(api_key: nil)
        render json: {success: true}
      end
    end
  end
end
