class LifelinesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]
  before_action :verify_slack_token!, only: [:create]

  def create
    Lifeline.add_lifeline params[:user_id] 
    render json: { text: "BTW- sorry I haven\'t gotten back to you yet. I will do it soon.", username: "D.Zoolander" }
  rescue StandardError => e
    Rails.config.env.error_handler.(e)
    render json: { text: "Sorry, I can't do that thing you asked. I'm not sure what you're talking about.", username: "Mugatu" }
  end

  private

    def verify_slack_token!
    ENV["WEBHOOK_SLACK"] == params[:token]
    rescue StandardError => e
      Rails.configuration.handle_errors.(e)
      render json: { text: "BTW- Sorry, I can't find that thing earlier.", username: "Mugatu" }
    end

end