class SmsController < ApplicationController
  def index

  end

  def reply
    puts params
    puts params[:Body]
    twilio_client.messages.create(
      to: "+13233016764",
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: params[:Body]
    )
  end

  private
  def message_params

  end
end
