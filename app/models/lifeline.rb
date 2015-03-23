class Lifeline < ActiveRecord::Base
require "twilio-ruby"
require 'Figaro'

T_ACCOUNT_SID = Figaro.env.T_ACCOUNT_SID
T_AUTH_TOKEN = Figaro.env.T_AUTH_TOKEN
KATIES_PHONE = Figaro.env.KATIES_PHONE
KATIES_TWILIO = Figaro.env.KATIES_TWILIO


  def self.add_lifeline(slack_id)
    user = User.lookup_by_slack_id slack_id
    user.new_lifeline
  end

  @client = Twilio::REST::Client.new(T_ACCOUNT_SID, T_AUTH_TOKEN)



  def self.send_sos user
  # Should this line go in another function? I feel like it is going to be reused.
  @client.account.messages.create(
      from: KATIES_TWILIO, 
      to: user.phone_number, 
      body: "Texting from inside the LifeLine class.")
  rescue Twilio::REST::RequestError => e
  	e.message
  end

  @minor_messages = [
    "http://twimlets.com/message?Message%5B0%5D=This%20is%20your%20mom.%20You%20should%20take%20this%20call.&"]

  @major_messages = [
    "http://twimlets.com/message?Message%5B0%5D=Hi%20there!%20This%20is%20your%20grandmother%20calling.%20I",
    "http://twimlets.com/message?Message%5B0%5D=Just%20repeat%20after%20me%3A%20%22Really%3F%3F%20I%20have%20to%20come%20into%20work%20NOW%3F%20Fiiiine.%22&",
    "http://twimlets.com/message?Message%5B0%5D=Hi%2C%20this%20is%20your%20landlord.%20A%20pipe%20has%20burst%20in%20your%20building%20and%20you%20should%20go%20home%20NOW.&",
    "http://twimlets.com/message?Message%5B0%5D=Hi%2C%20this%20is%20your%20doctor%20calling.%20Your%20pregnancy%20results%20came%20back!%20&",
    ]

  def self.call_me user
    @client.account.calls.create(
      from: KATIES_TWILIO, 
      to: user.phone_number, 
      url: @major_messages.sample, 
      body: "You need to go.")
  rescue Twilio::REST::RequestError => e
    e.message
  end
	
end
 

