class MessagesController < ApplicationController 
  def reply
    message = params["Body"]
    from = params["From"]
    twilio
    mms = @client.messages.create(
      from: Rails.application.secrets.twilio_number,
      to: from_number,
      body: "Test",
      media_url: 'https://api.nasa.gov/images/apod.jpg'
    )
  end
 
  private
 
  def twilio
    twilio_sid = Rails.application.secrets.twilio_sid
    twilio_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new twilio_sid, twilio_token
  end
end