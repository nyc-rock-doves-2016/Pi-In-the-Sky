class FavoritesController < ApplicationController

  def create
    user = User.find_by(id: session[:user_id])
    global_data_object = GlobalDataObject.last
    @favorite = Favorite.new(user_id: user.id, global_data_object_id: global_data_object.id)
    if @favorite.save
      redirect_to global_data_objects_path
    end
  end

end
