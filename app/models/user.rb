class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def new_lifeline(slack_user_id)
    Lifeline.create(user_id: self.id, slack_id: slack_user_id)
  end
end
