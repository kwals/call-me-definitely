class Lifeline < ActiveRecord::Base

  def self.add_lifeline(slack_id)
    user = User.lookup_by_slack_id slack_id
    user.new_lifeline
  end

end
