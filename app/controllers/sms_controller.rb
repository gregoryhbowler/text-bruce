class SmsController < ApplicationController
  include ApplicationHelper

  skip_before_action :verify_authenticity_token

  def index

  end

  def reply
    puts params
    puts "here is the body #{params[:Body]}"
    if User.where(phone_number: params[:From]).count ==0
      twilio_client.messages.create(
        to: params[:From],
        from: ENV['TWILIO_PHONE_NUMBER'],
        body: "Greetings from Bruce! To use this gnarly service, you need to sign up here. See you soon! [put link here]"
      )
      return
    end
    if params[:From] == "+13233016764"

    else
      twilio_client.messages.create(
        to: "+13233016764",
        from: ENV['TWILIO_PHONE_NUMBER'],
        body: params[:Body]
      )
    end
    respond_to do |format|
      format.json { render :status => 200 }
    end
  end

  private
  def message_params

  end
end
