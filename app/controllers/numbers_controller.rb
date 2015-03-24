class NumbersController < ApplicationController
  T_ACCOUNT_SID = Figaro.env.T_ACCOUNT_SID
  T_AUTH_TOKEN = Figaro.env.T_AUTH_TOKEN
  KATIES_TWILIO = Figaro.env.KATIES_TWILIO


  before_action :authenticate_user!

  def show
  end

  def update
    number = params[:phone_number]
    #FIXME need to verify phone number without adding '1' to beginning
    # .gsub(/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, '1\1\2\3')
    
    if number.length == 10
      current_user.update(phone_number: number)
      flash[:notice] = "Phone number confirmed. Your ejector seat is primed."
      
    # Authy stuff and redirect to verify page
     authy = Authy::API.register_user(
        email: current_user.email,
        cellphone: current_user.phone_number,
        country_code: "1"
      )
      current_user.update(authy_id: authy.id)

      # Send an SMS to your user
      Authy::API.request_sms(id: current_user.authy_id)
      redirect_to verify_path
    else
      flash[:alert] = "Something went wrong with your number! Ejector seat malfunction!"
      redirect_to number_path
    end
  end

  def verify
    @user = current_user

    # Use Authy to send the verification token
    token = Authy::API.verify(id: @user.authy_id, token: params[:token])

    if token.ok?
      # Mark the user as verified for get /user/:id
      @user.update(verified: true)

      # Send an SMS to the user 'success'
      send_message("You did it! Signup complete :)")

      # Show the user profile
      redirect_to "/"
    else
      flash.now[:danger] = "Incorrect code, please try again"
      render :show_verify
    end
  end

  def resend
    @user = current_user
    Authy::API.request_sms(id: @user.authy_id)
    flash[:notice] = "Verification code re-sent"
    redirect_to verify_path
  end

  def send_message(message)
    @user = current_user
    twilio_number = KATIES_TWILIO
    @client = Twilio::REST::Client.new T_ACCOUNT_SID, T_AUTH_TOKEN
    message = @client.account.messages.create(
      :from => twilio_number,
      :to => "1"+@user.phone_number,
      :body => message
    )
    puts message.to
  end

end