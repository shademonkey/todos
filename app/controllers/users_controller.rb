class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new create_user_params

    if @user.save
      flash[:success] = "Successfully registered"
      redirect_to login_path
    else
      render :new
    end
  end

  private
  def create_user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
