class DataObjectController < ApplicationController

  def create
    # parse JSON?
    json = JSON.parse(get"api.breezometer.com/baqi/?lat="+latlength+"&lon="+lnglength+"&key=c0bfb33a27924f7e95a828abc931d5a0")
    binding.pry
    @data_object = Data_object.new()
    redirect_to root
  end


end
