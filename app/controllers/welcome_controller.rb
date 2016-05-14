class WelcomeController < ApplicationController

  def index
    @data_object = DataObject.last
  end


end
