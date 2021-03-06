class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:home]

  def after_sign_in_path_for(resource)
    if current_user.phone_number
      root_path
    else
      number_path
    end
  end

  def home 
  end
  
end
