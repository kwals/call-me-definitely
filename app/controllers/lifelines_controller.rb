class LifelinesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    #if authenticity token is the same as one in ENV do
    slack_user_id = params["user_id"]
    current_user.new_lifeline(slack_user_id)
  end
end