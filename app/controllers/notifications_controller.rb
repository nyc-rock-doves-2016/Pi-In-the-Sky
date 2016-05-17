class NotificationsController < ApplicationController

  skip_before_action :verify_authenticity_token

  def below_threshold
    @user = User.find_by(id: session[:user_id])
    @user.global_data_objects.each do |object|
    if @user.alert_level < object.breezometer_aqi
      # code run upon user show refresh
      # create alert object OR find alert object and check if ready to send
      # object.alert exists? this checks if we need to create
        # current time
        # ready_to_send?
        # message

      # alert joint table betweeen user and globaldata
      # ready to send defaults to false, switches true when global data object goes back above threshold
      send_alert
    end
  end

  def send_alert
    # find by user global data object
    # check users GDO for alerts

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

    end
  end

end




