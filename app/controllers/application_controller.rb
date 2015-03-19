class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :authenticate_user!, except: [:home]

  def home
  end

  rescue User::InvalidRequestError => e
  rescue_from Exception => "Sorry, I can't do that thing you asked. I'm not sure what you're talking about."
end
