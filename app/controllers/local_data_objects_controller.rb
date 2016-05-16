class LocalDataObjectsController < ApplicationController

  def create
    binding.pry
    @local_data_object = LocalDataObject.new()
  end

  def update

  end

end
