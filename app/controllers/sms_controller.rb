class SmsController < ApplicationController
  include ApplicationHelper

  skip_before_action :verify_authenticity_token

  def index

  end

  def reply
    puts params
    puts "here is the body #{params[:Body]}"
    u = User.where(phone_number: params[:From]).first
    if !u
      twilio_client.messages.create(
        to: params[:From],
        from: ENV['TWILIO_PHONE_NUMBER'],
        body: "Greetings from Bruce! To use this gnarly service, you need to sign up here. See you soon! [put link here]"
      )
      return
    end
    if params[:From] == "+13233016764"
      name = params[:Body].slice(0..(str.index('-')-1))
      if User.where(name: name).first

        twilio_client.messages.create(
          to: u.phone_number,
          from: ENV['TWILIO_PHONE_NUMBER'],
          body: params[:Body].slice(str.index('-')..str.length-1)
        )
      else

      end
    else
      twilio_client.messages.create(
        to: "+13233016764",
        from: ENV['TWILIO_PHONE_NUMBER'],
        body: "#{u.name}- #{params[:Body]}"
      )
      Message.create(body: params[:Body], user: u)
    end
    respond_to do |format|
      format.json { render :status => 200 }
    end
  end

  private
  def message_params

  end
end
