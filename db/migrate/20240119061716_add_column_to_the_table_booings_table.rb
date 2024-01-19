class AddColumnToTheTableBooingsTable < ActiveRecord::Migration[7.1]
  def change
    add_column :table_bookings, :cancellation, :boolean, default: false
  end

end
