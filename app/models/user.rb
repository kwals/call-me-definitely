class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :registerable, and :omniauthable
  devise :database_authenticatable, 
         :recoverable, :rememberable, :trackable, :validatable, 
         :omniauthable, omniauth_providers: [:slack]

  serialize :auth_data, JSON

  def self.from_omniauth data
    slack_id = data.uid
    unless User.find_by(slack_id: slack_id)
      where(slack_id: slack_id).first_or_create! do |u|
        user_data = HTTParty.get("https://slack.com/api/users.info", :query => { :token => Figaro.env.slack_token, :user => "#{slack_id}"})
        u.email = user_data["user"]["profile"]["email"]
        u.password = Figaro.env.generic_password
        u.slack_id = slack_id
        u.auth_data = data
      end
    end
  end
end
