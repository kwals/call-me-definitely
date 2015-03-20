class LifelinesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]
  before_action :verify_slack_token!, only: [:create]

  def create

    if Lifeline.add_lifeline params[:user_id] 
      render json: "BTW- sorry I haven't gotten back to you yet. I will do it soon."
    else
      render json: "Sorry, I can't do that thing you asked. I'm not sure what you're talking about."
    end
  end

  private

    def verify_slack_token!
       render json: "BTW- Sorry, I couldn't find that thing earlier." unless (ENV["TRUE_SLACK"] == params[:token]) && (User.lookup_by_slack_id params[:id])
      # redirect_to errors_path
      # raise User::InvalidRequestError, "I could not find what you were looking for." 
    end

end