class GlobalDataObjectsController < ApplicationController

  def index
    @user = User.find_by(id: session[:user_id])
    @global_data_object = GlobalDataObject.last
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
    @global_data_object = GlobalDataObject.find(params[:id])
   binding.pry
    call_breezy_api
  end

  def call_breezy_api
    call= "https://api.breezometer.com/baqi/?lat="+latlength+"&lon="+lnglength+"&key=c0bfb33a27924f7e95a828abc931d5a0"
    auth = {:username => "test", :password => "password"}
    url = HTTParty.get("https://surveys.com#{call}",
          :basic_auth => auth,
          :headers => { 'ContentType' => 'application/json' } )
    response = JSON.parse(url.body)

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
