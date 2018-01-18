class MessagesController < ApplicationController 
  skip_before_action :verify_authenticity_token

  def reply
    message = params["Body"]
    if message["space me"] || message["SPACE ME"]
      from = params["From"]
      get_nasa_url
      twilio
      mms = @client.messages.create(
        body: @explanation,
        from: Rails.application.secrets.twilio_number,
        to: from,
        media_url: @url
      )
    end
  end
 
  private
 
  def twilio
    twilio_sid = Rails.application.secrets.twilio_sid
    twilio_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new(twilio_sid, twilio_token)
  end

  def get_nasa_url
    nasa_key = Rails.application.secrets.nasa_api
    nasa_response = Faraday.get("https://api.nasa.gov/planetary/apod?api_key=#{nasa_key}")
    body_hash = JSON.parse(nasa_response.body)
    @url = body_hash['url']
    @explanation = body_hash['explanation']

  end
end