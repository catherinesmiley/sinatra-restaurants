class CreateMenuItems < ActiveRecord::Migration
  def change
    create_table :menu_items do |t|
      t.string :name 
      t.string :description 
      t.integer :restaurant_id
    end 
  end
end
