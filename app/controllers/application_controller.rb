class ApplicationController < ActionController::Base

  include ApiHelper
  include SessionsHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session


  GOOGLE_API_KEY = ENV["GOOGLE_API_KEY"]
  BREEZY_KEY = ENV["BREEZY_API_KEY"]
end
