class UsersController < ApplicationController
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
