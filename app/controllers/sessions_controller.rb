class SessionsController < ApplicationController
  include ApplicationHelper
  def new
  end

  def create
    phone_number = check_phone_format(params[:phone_number])
    if phone_number == false
      respond_to do |format|
        flash.now.alert = "Improper Phone Number Format. No - or + symbols."
        format.json { render :json => "Improper Phone Number Format. No - or + symbols", :status => :unprocessable_entity }
        format.html { render :new }
      end
      return
    end
    params[:phone_number] = phone_number

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
