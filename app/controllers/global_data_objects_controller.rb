class GlobalDataObjectsController < ApplicationController

  def index
    @global_data_object = GlobalDataObject.last
  end

  def create
    if params[:response][:data_valid] == "true"
      @global_data_object = GlobalDataObject.create(global_data_object_params)
      @global_data_object.city = params[:city]
      redirect_to root_path
    else
      redirect_to root_path
    end
  end

  def show
       @global_data_object = GlobalDataObject.find(params[:id])
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
