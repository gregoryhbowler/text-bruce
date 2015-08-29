# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  name            :string
#  password_digest :string
#  phone_number    :string
#  phone_pin       :string
#  phone_verified  :boolean          default(FALSE)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class User < ActiveRecord::Base

  has_secure_password

  validates_presence_of :name
  validates_presence_of :phone_number
  validates_uniqueness_of :phone_number

  def generate_pin
    self.phone_pin = rand(0000..9999).to_s.rjust(4, "0")
    save
  end

  def twilio_client
    Twilio::REST::Client.new(ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN'])
  end

  def send_pin
    twilio_client.messages.create(
      to: phone_number,
      from: ENV['TWILIO_PHONE_NUMBER'],
      body: "Your PIN is #{phone_pin}"
    )
  end

end
