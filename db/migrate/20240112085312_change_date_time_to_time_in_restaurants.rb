class ChangeDateTimeToTimeInRestaurants < ActiveRecord::Migration[7.1]
  def change
    change_column :restaurants, :available_start_time, :time
    change_column :restaurants, :available_end_time, :time
  end
end
