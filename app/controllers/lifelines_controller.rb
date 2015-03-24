class LifelinesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]
  before_action :verify_slack_token!, only: [:create]

  def create
    #STRONG PARAMS  AUTHTOKEN AND SLACK_ID
    # @sos = params[:text] for parsing of timed request
  Lifeline.add_lifeline params[:user_id] 
    Lifeline.call_me(User.lookup_by_slack_id(params[:user_id]))
    render json: { text: "Hey- do you have a minute? It's an emergency.", username: "D.Zoolander" }
  rescue StandardError => e
    Rails.configuration.handle_errors.(e)
    render json: { text: "Dude, who even are you?", username: "Mugatu" }
  end

  private

    def verify_slack_token!
    ENV["WEBHOOK_SLACK"] == params[:token] 
    rescue StandardError => e
      Rails.configuration.handle_errors.(e)
      render json: { text: "Dude, who are you?", username: "Mugatu" }
    end

    # For later parsing of 'in # of minutes request'
    # def get_min_request
    #   if @sos
    #     @sos
    #   end
    # end

end