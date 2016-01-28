class UsersController < ApplicationController


  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)

    if @user.save
      redirect_to root_path
    else
      puts(@user.errors.any?)
      puts(@user.errors.count)
      puts(@user.errors.full_messages)
      # redirect_to signup_path
      render 'new'
    end
  end

  def show
    @user = current_user
  end

  def update
    @user = current_user
    @user.update_attributes(user_params)
    redirect_to user_path
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end