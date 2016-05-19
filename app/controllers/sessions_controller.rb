class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to global_data_objects_path
    else
      @errors = ['Invalid Email or Password']
      render 'new'
  end
end

  def destroy
    session.clear
    redirect_to root_path
  end

end
