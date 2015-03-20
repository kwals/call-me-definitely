class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, omniauth_providers: [:slack]

  serialize :auth_data, JSON
  serialize :user_data, JSON

  def self.from_omniauth data
    slack_id = data.uid
    if User.find_by(slack_id: slack_id)
      User.find_by(slack_id: slack_id)
    else
      where(slack_id: slack_id).first_or_create! do |u|
        user_data = HTTParty.get("https://slack.com/api/users.info", :query => { :token => Figaro.env.slack_token, :user => "#{slack_id}"})
        u.email = user_data["user"]["profile"]["email"]
        u.password = SecureRandom.hex 64
        u.slack_id = slack_id
        u.auth_data = data
        u.user_data = user_data
        phone = user_data["user"]["profile"]["phone"]
        u.phone_number = phone unless phone.nil?
      end
    end
  end

  def self.lookup_by_slack_id(slack_user_id)
    User.where(slack_id: slack_user_id).first
  end

  def new_lifeline
    Lifeline.create!(user_id: self.id)
  end

end
