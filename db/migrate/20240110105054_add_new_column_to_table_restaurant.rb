class AddNewColumnToTableRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_column :table_restaurants, :is_active, :boolean, default: true
  end
end
