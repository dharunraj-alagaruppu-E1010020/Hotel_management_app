class CreateTableBookings < ActiveRecord::Migration[7.1]
  def change
    create_table :table_bookings do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :table_restaurant, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
