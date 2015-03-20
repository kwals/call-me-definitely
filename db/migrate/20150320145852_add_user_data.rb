class AddUserData < ActiveRecord::Migration
  def change
    add_column :users, :user_data, :text
  end
end
