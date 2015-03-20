class OmniauthCallbacksController < Devise::OmniauthCallbacksController

  def slack
    user = User.from_omniauth request.env["omniauth.auth"]
    redirect_to ("/")
  end

end