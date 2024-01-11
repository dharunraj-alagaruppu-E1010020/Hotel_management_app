class RenameHotelToRestaurant < ActiveRecord::Migration[7.1]
  def change
    rename_table :hotels, :restaurants
  end
end
