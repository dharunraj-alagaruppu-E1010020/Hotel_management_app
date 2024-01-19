class AddRestaurantIdToTableBookings < ActiveRecord::Migration[7.1]
  def change
    add_column :table_bookings, :restaurant_id, :integer
  end
end
