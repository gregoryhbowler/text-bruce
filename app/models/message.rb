class Message < ActiveRecord::Base
  belongs_to :from_user,  :class_name => 'User' # from_user_id field fk Users
  belongs_to :to_user,    :class_name => 'User' # to_user_id field fk Users
  belongs_to :thread, :class_name => 'Message'  # Reference to parent message
  has_many :replies,  :class_name => 'Message', :foreign_key => 'thread_id'

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

  def sender
    User.find_by(number: from)
  end

end
