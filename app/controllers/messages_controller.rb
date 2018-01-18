class MessagesController < ApplicationController 
  skip_before_action :verify_authenticity_token

  def reply
    message = params["Body"]
    if message["space me"] || message["SPACE ME"]
      from = params["From"]
      nasa_info = get_apod
      twilio
      mms = @client.messages.create(
        body: nasa_info[1],
        from: Rails.application.secrets.twilio_number,
        to: from,
        media_url: nasa_info[0]
      )
    end
  end
 
  private
 
  def twilio
    twilio_sid = Rails.application.secrets.twilio_sid
    twilio_token = Rails.application.secrets.twilio_token
    @client = Twilio::REST::Client.new(twilio_sid, twilio_token)
  end

  def get_apod
    nasa_key = Rails.application.secrets.nasa_api
    nasa_response = Faraday.get("https://api.nasa.gov/planetary/apod?api_key=#{nasa_key}")
    body_hash = JSON.parse(nasa_response.body)
    return [body_hash['url'], body_hash['explanation']]
  end
end