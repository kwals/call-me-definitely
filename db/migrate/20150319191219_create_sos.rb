class CreateSos < ActiveRecord::Migration
  def change
    create_table :lifelines do |t|
    	t.belongs_to :user
      t.timestamps null: false
    end
  end
end
