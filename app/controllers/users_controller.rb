class UsersController < ApplicationController

  skip_before_action :verify_authenticity_token

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_path(@user)
    else
      @errors = @user.errors.full_messages
      render 'new'
    end
  end

    def show
      @user = User.find_by(id: params[:id])
      @favorite_objects = @user.global_data_objects
      @favorite_objects.each do |object|
        response = call_breezy_api(object)
        object.update_attributes(breezometer_aqi: response["breezometer_aqi"], dominant_pollutant_description: response["dominant_pollutant_description"], breezometer_description: response["breezometer_description"] )

        if @user.alert_level > object.breezometer_aqi
          alert = Alert.create_or_find_by(global_data_object_id: object.id, message: "Alert! You have fallen below your AQI threshold for #{object.city}, #{object.state}")
          send_alert(alert)
         #check to see if alert sent
      end
    end

    def edit
      @user = User.find_by(id:params[:id])
    end

    def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to @user
    else
      render 'edit'
    end
  end

  def call_breezy_api(object)
    url = HTTParty.get("https://api.breezometer.com/baqi/?location=#{object.city},+#{object.state}&key=c0bfb33a27924f7e95a828abc931d5a0", :verify => false)
    response = JSON.parse(url.body)
  end


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

  def send_alert(alert)
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


    private

    def user_params
      params.require(:user).permit(:first_name,
                                   :last_name,
                                   :password,
                                   :email,
                                   :phone,
                                   :location)
    end

end
