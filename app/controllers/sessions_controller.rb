class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_phone_number(params[:phone_number])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_url, notice: "Logged in!"
    else
      flash.now.alert = "Phone number or password is invalid."
      render "new"
    end
  end

  def destroy

    session[:user_id] = nil
    redirect_to root_url, notice: "You have logged out."

  end

  private

end
