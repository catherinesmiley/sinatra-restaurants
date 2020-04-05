class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name 
      t.string :city
      t.string :category
      t.string :notes 
      t.integer :user_id
    end 
  end
end
