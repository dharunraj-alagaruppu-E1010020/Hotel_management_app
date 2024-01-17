class AddAvailableTimesToRestaurants < ActiveRecord::Migration[7.1]
  def change
    add_column :restaurants, :available_start_time, :datetime
    add_column :restaurants, :available_end_time, :datetime
  end
end
