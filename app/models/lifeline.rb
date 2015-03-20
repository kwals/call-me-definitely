class Lifeline < ActiveRecord::Base
require "twilio-ruby"
require 'Figaro'

T_ACCOUNT_SID = Figaro.env.T_ACCOUNT_SID
T_AUTH_TOKEN = Figaro.env.T_AUTH_TOKEN
KATIES_PHONE = Figaro.env.KATIES_PHONE
KATIES_TWILIO = Figaro.env.KATIES_TWILIO


	def create

	end

	def self.send_sos user
		# Should this line go in another function? I feel like it is going to be reused.
	client = Twilio::REST::Client.new(T_ACCOUNT_SID, T_AUTH_TOKEN)

	client.account.messages.create(
		from: KATIES_TWILIO, 
		to: user.phone_number, 
		body: "Texting from inside the LifeLine class.")

	end


	def self.call_me user
		client = Twilio::REST::Client.new(T_ACCOUNT_SID, T_AUTH_TOKEN)
		client.account.calls.create(
			from: KATIES_TWILIO, 
			to: user.phone_number, 
			url: "http://twimlets.com/holdmusic?Bucket=com.twilio.music.rock", 
			body: "Music!")
	end
	
end
 

