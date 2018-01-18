class MessagesController < ApplicationController 
  skip_before_action :verify_authenticity_token

  def reply
    message = params["Body"]
    from = params["From"]
    twilio
    sms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from,
      body: "Test",
    )
  end
 
  private
 
  def twilio
    twilio_sid = Rails.application.secrets.twilio_sid
    twilio_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new(twilio_sid, twilio_token)
  end
end