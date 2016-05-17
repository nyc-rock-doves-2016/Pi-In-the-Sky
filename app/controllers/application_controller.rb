class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  
  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    session[:user_id] && current_user.present?
  end


  GOOGLE_API_KEY = ENV["GOOGLE_API_KEY"]
  BREEZY_KEY = ENV["BREEZY_API_KEY"]
end
