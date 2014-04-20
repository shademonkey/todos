class SessionController < ApplicationController
  def authenticate
    if user = User.authenticate(params[:email], params[:password])
      # Save the user ID in the session so it can be used in
      # subsequent requests
      puts user.inspect
      session[:current_user_id] = user.id
      current_user
      flash[:success] = "Successfully logged in"
      redirect_to todos_path
    else
      flash[:error] = "Wrong username and password"
      redirect_to login_path
    end
  end

  def login
  end

  def destroy
    session[:current_user_id] = nil
    @current_user = nil
    flash[:success] = "Successfully logged out"
    redirect_to home_path
  end
end
