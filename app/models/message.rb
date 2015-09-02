class Message < ActiveRecord::Base
  belongs_to :user

  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def initialize(attributes)
    @to = attributes[:to]
    @from = attributes[:from]
    @body = attributes[:body]
    @status = attributes[:status]
  end

  def receiver
    User.find_by(number: to)
  end

end
