class LifelinesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]
  before_action :verify_slack_token!, only: [:create]

  def create
    Lifeline.add_lifeline params[:user_id] 
    render json: { text: "BTW- sorry I haven\'t gotten back to you yet. I will do it soon.", username: "D.Zoolander" }
  rescue StandardError => e
    #DO RAILSY THINGS
    render json: { text: "Sorry, I can't do that thing you asked. I'm not sure what you're talking about.", username: "Mugatu" }
  end

  private

    def verify_slack_token!
      ENV["WEBHOOK_SLACK"] == params[:token] #&& (User.lookup_by_slack_id params[:id])
    rescue StandardError => e
      #Do Railsy things
      render json: { text: "BTW- Sorry, I can't find that thing earlier.", username: "Matilda" }
    end

end