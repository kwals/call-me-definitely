class LifelinesController < ApplicationController
  
  skip_before_action :verify_authenticity_token, only: [:create]
  skip_before_action :authenticate_user!, only: [:create]
  before_action :verify_slack_token!, only: [:create]

  def create

    Lifeline.add_lifeline params[:user_id] 
      render json: "BTW- sorry I haven't gotten back to you yet. I will do it soon."
    rescue StandardError => e
      #Rails
      render json: { text: "Sorry, I can't do that thing you asked. I'm not sure what you're talking about." }
    end
  end

  private

    def verify_slack_token!
      (ENV["SLASH_SLACK"] == params[:token])
      rescue StadardError => e
        #Rails
        render json: "BTW- Sorry, I couldn't find that thing you were looking for."
      end
    end

end