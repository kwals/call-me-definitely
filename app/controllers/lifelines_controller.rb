class LifelinesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]
  before_action :verify_slack_token!, only: [:create]

  def create
    if Lifeline.add_lifeline params[:user_id] 
      render json: "BTW- sorry I haven't gotten back to you yet. I will soon."
    else
      render json: "Sorry, I can't do that thing you asked. I'm not sure what you're talking about."
    end
  end

  private

    def verify_slack_token!
      raise User::InvalidRequestError, "I could not find what you were looking for." unless (ENV["TRUE_SLACK"] == params[:token]) && (User.lookup_by_slack_id params[:id])
      render json: "I could not find what you were looking for."
    end

end