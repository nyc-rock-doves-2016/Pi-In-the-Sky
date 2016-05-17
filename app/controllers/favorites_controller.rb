class FavoritesController < ApplicationController

  def create
    user = User.find_by(id: session[:user_id])
    global_data_object = GlobalDataObject.last
    location = global_data_object.city
    if global_data_object.find_by(city: location) == nil
      @favorite = Favorite.create(user_id: user.id, global_data_object_id: global_data_object.id)
    else
      @errors = ["You have already favorited this city!"]
    end
  end

  def destroy
     @favorite = Favorite.where(user_id: session[:user_id]).first.destroy
      redirect_to user_path
  end

end
