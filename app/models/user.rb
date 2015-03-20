class User < ActiveRecord::Base

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.lookup_by_slack_id(slack_user_id)
    User.where(slack_id: slack_user_id).first
  end

  def new_lifeline
    Lifeline.create!(user_id: self.id)
  end
  
end
