class CreateTableRestaurants < ActiveRecord::Migration[7.1]
  def change
    create_table :table_restaurants do |t|
      t.integer :table_number
      t.integer :no_of_chairs
      t.references :restaurant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
