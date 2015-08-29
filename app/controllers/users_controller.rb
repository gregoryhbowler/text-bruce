class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    puts user_params[:phone_number]

    if User.where(phone_number: user_params[:phone_number]).count >0
      puts "user with phone number exists"
      @user = User.where(phone_number: user_params[:phone_number]).first
      if @user.phone_verified
        respond_to do |format|
          format.json { render :json => "An account associated with this phone number already exists.", :status => :unprocessable_entity }
        end
        return
      end
      @user.update_attributes(user_params)
    else
      puts "no user with this phone number"
      @user = User.new(user_params)
    end
    @user.password_digest = Faker::Internet.password(8)
    if @user.save
      @user.generate_pin
      @user.send_pin

      session[:user_id] = @user.id
      respond_to do |format|
        format.json { render :json => @user, :status => 200 }
      end
    else
      respond_to do |format|
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end

  end

  def verify_phone
    user = User.find(params[:user_id])

    if user.phone_verified
      user.errors << "Account with this phone number already verified."
      format.json { render :json => user.errors, :status => :unprocessable_entity }
      # render :back, error: "Account with this phone number already verified."
      return
    end

    if !user.phone_pin || user.phone_pin != user_params[:phone_pin]
      user.errors << "Account with this phone number already verified."
      format.json { render :json => user.errors, :status => :unprocessable_entity }
      # render :back, error: "Incorrect phone pin."
      return
    end

    # user.phone_verified = true
    params[:user][:password_digest] = BCrypt::Password.create(params[:user][:password_digest]).to_s

    if user.update_attributes(user_params) && user.update_attributes(phone_verified: true)
      respond_to do |format|
        format.json { render :json => user, :status => 200 }
      end
    else
      respond_to do |format|
        format.json { render :json => user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # def create
  #   @phone_number = PhoneNumber.find_or_create_by(phone_number: params[:phone_number][:phone_number])
  #   @phone_number.generate_pin
  #   @phone_number.send_pin
  #   respond_to do |format|
  #     format.js # render app/views/phone_numbers/create.js.erb
  #   end
  # end

  ##
  ## create a user, name and phone nubmer
  ##
  ## find that user, verify the pin, in the method verify the account
  ## end the hashed password into the database w/ the verified account

  private

  def user_params
    # params[:user][:password_digest] = BCrypt::Password.create(params[:user][:password_digest]).to_s
    params.require(:user).permit(:name, :phone_number, :phone_pin, :password_digest)
  end



end
