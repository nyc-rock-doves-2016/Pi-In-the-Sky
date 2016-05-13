class DataObjectsController < ApplicationController

  def create
    @data_object = Data_object.new()
    redirect_to root
  end


end
