class LifelinesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]

  def create
    #if authenticity token is the same as one in ENV do
    slack_id = params[:user_id]
    user = User.lookup_user_by_slack slack_id
    user.new_lifeline slack_id
  end
end