class NumbersController < ApplicationController

  before_action :authenticate_user!

  def show
  end

  def update
    number = params[:phone_number].gsub(/^\(?([0-9]{3})\)?[-. ]?([0-9]{3})[-. ]?([0-9]{4})$/, '1\1\2\3')
    
    if number.length == 11
      current_user.update(phone_number: number)
      flash[:notice] = "Phone number confirmed. Your ejector seat is primed."
      redirect_to ("/")
    else
      flash[:alert] = "Something went wrong with your number! Ejector seat malfunction!"
      redirect_to number_path
    end
  end
end