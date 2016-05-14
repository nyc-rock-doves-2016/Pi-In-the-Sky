class FavoritesController < ApplicationController

  def create
    @user = User.find_by(id:session[:user_id])
    @favorite = Favorite.new(user_id: current_user.id, data_object_id: )
  end

end
