class DataObjectsController < ApplicationController

  def create
    if params[:response][:data_valid] == "true"
      @data_object = DataObject.create(data_object_params)
      redirect_to '/'
    else
      redirect_to '/'
    end
  end

  def show
       @data_object = DataObject.find(params[:id])
  end


private
  def data_object_params
    params.require(:response).permit(:type,
                                     :country_name,
                                     :datetime,
                                     :breezometer_aqi,
                                     :breezometer_description,
                                     dominant_pollutant_text: [:effects])
  end
end
