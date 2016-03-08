class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by_email(params[:session][:email])
    if @user && @user.authenticate(params[:session][:password])
      # session[:user_id] = @user.id
      if params[:remember_me]
        cookies.permanent[:auth_token] = @user.auth_token
        print("Permmmmmmmmmmmmin   - #{params[:remember_me]}")
      else
        cookies[:auth_token] = @user.auth_token
        print("regggggggggggmmmmmmmmmmmmin   - #{params[:remember_me]}")
      end


      redirect_to '/search'

      print("adding sessssssssion #{session[:user]}")
      logger.info "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
      logger.info @user.id
      logger.info "-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------"

    else
      flash.now.alert = "Invalid email or password"
      redirect_to '/login'
    end
  end

  def destroy
    # session[:user_id] = nil
    cookies.delete(:auth_token)
    redirect_to '/'
  end

end
