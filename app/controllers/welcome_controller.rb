class WelcomeController < ApplicationController

  def index
    @data_objects = Data_objects.all
  end


end
