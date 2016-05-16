class LocalDataObjectsController < ApplicationController

  def create
    @local_data_object = LocalDataObject.new(user_id: params[:user_id], sensor_output: params[:sensor_output])
    if @local_data_object.save
      render text: 'OK'
    else
      render text: 'Failed to save'
    end
  end

  def latest
    ldo = LocalDataObject.last
    render json: { reading: ldo.sensor_output }
  end


end
