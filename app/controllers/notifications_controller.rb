class NotificationsController < ApplicationController

  skip_before_action :verify_authenticity_token


  def notify

    alert_message = "Air Quality is Poor today."
    user = User.all
    phone_numbers = []
    user.each do |user|
      phone_numbers.push(user.phone)
    end

    client = Twilio::REST::Client.new Rails.application.secrets.twilio_account_sid, Rails.application.secrets.twilio_auth_token

    # twilio_number = Rails.application.secrets.twilio_number


    phone_numbers.each do |phone_number|

      message = client.messages.create(
        from: "+13479336675",
        to: phone_number,
        body: alert_message,)

      render plain: message.status
    end
  end

end




