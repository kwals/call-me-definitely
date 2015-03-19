class LifelinesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    #if authenticity token is the same as one in ENV do
    current_user.new_lifeline(params[:user_id])
  end
end