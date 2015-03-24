class AddAuthyIdtouSer < ActiveRecord::Migration
  def change
  	add_column :users, :authy_id, :integer 
  end
end
