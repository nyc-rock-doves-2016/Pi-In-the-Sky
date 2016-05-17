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

    # error handle for when lat lon returns API data but country address doesn't
    # try to make call with more precise address for accuracy

      @favorite_objects.each do |object|
        response = call_breezy_api(object)
        object.assign_attributes(breezometer_aqi: response["breezometer_aqi"], dominant_pollutant_description: response["dominant_pollutant_description"], breezometer_description: response["breezometer_description"] )

        if object.save
        else

        end

        # if user exists, set 'ready to send' = true if object is higher than threshold
          if object.alert
            alert = object.alert
            @user.check_threshold(alert, object)
          end

        # AQI is below user threshold
        if (@user.alert_level > object.breezometer_aqi) && (object.alert == true || object.alert == nil)
          alert = Alert.find_or_create_by(global_data_object_id: object.id, message: "Alert! You have fallen below your AQI threshold for #{object.city}, #{object.state}")
          @user.send_alert(alert)
          alert.ready_to_send? == false
         #check to see if alert sent
        end
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
