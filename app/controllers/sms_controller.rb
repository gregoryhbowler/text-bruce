class SmsController < ApplicationController
  def index

  end

  def reply
    puts params
    params[:from]
  end

  private
  def message_params

  end
end
