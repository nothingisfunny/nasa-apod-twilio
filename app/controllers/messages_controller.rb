class MessagesController < ApplicationController 
  skip_before_action :verify_authenticity_token

  def reply
    message = params["Body"]
    from = params["From"]
    twilio
    mms = @client.messages.create(
      body: "Here is your photo of the day!",
      from: Rails.application.secrets.twilio_number,
      to: from,
      media_url: "https://api.nasa.gov/images/apod.jpg"
    )
  end
 
  private
 
  def twilio
    twilio_sid = Rails.application.secrets.twilio_sid
    twilio_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new(twilio_sid, twilio_token)
  end
end