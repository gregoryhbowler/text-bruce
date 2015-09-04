module ApplicationHelper

  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def check_phone_format(phone_number)
    # phone_number = user_params[:phone_number]
    phone_number = phone_number.tr('+-', '').last(10)
    if !(phone_number.length == 10 || phone_number.length == 11 && phone_number[0] == '1')
      return false
    end

    phone_number = "+1#{phone_number}"
    # params[:user][:phone_number] = phone_number
    return phone_number
  end


end
