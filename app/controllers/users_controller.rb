class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "You are now BFFs with Bruce!"
    else
      render 'new'
    end
  end

  def create
    @phone_number = PhoneNumber.find_or_create_by(phone_number: params[:phone_number][:phone_number])
    @phone_number.generate_pin
    @phone_number.send_pin
    respond_to do |format|
      format.js # render app/views/phone_numbers/create.js.erb
    end
  end

  ## 
  ## create a user, name and phone nubmer
  ##
  ## find that user, verify the pin, in the method verify the account
  ## end the hashed password into the database w/ the verified account

  private

  def user_params
    params.require(:user).permit(:name, :phone_number, :password, :password_confirmation)
  end



end
