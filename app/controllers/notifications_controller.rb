class NotificationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def notify
    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token
    message = client.messages.create from: '+13235034566', to: '+13233016764', body: 'This appears to be working.'
    render plain: message.status
  end


end
