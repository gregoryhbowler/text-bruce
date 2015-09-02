class SmsController < ApplicationController

  skip_before_action :verify_authenticity_token
  
  def index

  end

  def reply
    puts params
    puts "here is the body #{params[:Body]}"
    twilio_client.messages.create(
      to: "+13233016764",
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: params[:Body]
    )
    respond_to do |format|
      format.json { render :status => 200 }
    end
  end

  private
  def message_params

  end
end
