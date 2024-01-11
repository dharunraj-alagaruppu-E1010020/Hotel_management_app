class AddNewColumnToRestaurant < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :is_active, :boolean, default: true
  end
end
