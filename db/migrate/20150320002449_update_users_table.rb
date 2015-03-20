class UpdateUsersTable < ActiveRecord::Migration
  def change
    add_column :users, :phone_number, :string
    add_column :users, :slack_id, :string
    add_column :users, :auth_data, :text
  end
end
