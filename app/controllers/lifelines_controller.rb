class LifelinesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]
  before_action :verify_slack_token!, only: [:create]

  def create
    Lifeline.add_lifeline params[:user_id] 
    render json: { text: "Hey- do you have a minute? It's an emergency.", username: "D.Zoolander" }
  rescue StandardError => e
    Rails.configuration.handle_errors.(e)
    render json: { text: "Dude, I don't even know who you are anymore.", username: "Mugatu" }
  end

private

  def verify_slack_token!
    ENV["WEBHOOK_SLACK"] == params[:token]
  rescue StandardError => e
    Rails.configuration.handle_errors.(e)
    render json: { text: "Sorry dude, I have no idea what you're talking about.", username: "Mugatu" }
  end

end