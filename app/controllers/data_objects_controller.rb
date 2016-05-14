class DataObjectsController < ApplicationController

  def create
    binding.pry
    @data_object = Data_object.new(data_object_params)
    redirect_to root
  end



private
  def data_object_params
    params.require(:data_object).permit(:type,
                               :location,
                               :date,
                               :aqi,
                               :pollutant,
                               :effects)
  end
end
