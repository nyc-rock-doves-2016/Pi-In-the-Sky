class GlobalDataObjectsController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
    @global_data_object = GlobalDataObject.last
    @local_data_object = LocalDataObject.last
  end

  def create
    if params[:response][:data_valid] == "true"
      @global_data_object = GlobalDataObject.create(global_data_object_params)
      @global_data_object.city = params[:city]
      @global_data_object.state = params[:state]
      @global_data_object.save
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def show
    @global_data_object = GlobalDataObject.find(params[:id])
  end

  def update
    # binding.pry
    user = User.find_by(id: session[:user_id])
    objects = user.global_data_objects
    global_data_object = GlobalDataObject.find(params[:id])
    response = call_breezy_api(global_data_object)
    binding.pry
    global_data_object.assign_attributes(global_data_object_params)
    redirect_to user_path(@user)
  end



private
  def global_data_object_params
    params.require(:response).permit(
                                     :country_name,
                                     :datetime,
                                     :breezometer_aqi,
                                     :breezometer_description,
                                     :dominant_pollutant_description,
                                     dominant_pollutant_text: [:effects])
  end
end
