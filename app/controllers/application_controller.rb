class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:home]

  def after_sign_in_path_for(resource)
    "https://callmedefinitely.ngrok.com"
  end

  def home
  end
  
end
