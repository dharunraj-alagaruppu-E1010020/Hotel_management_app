class TableBooking < ApplicationRecord
  belongs_to :table_restaurant
  belongs_to :user
  
end
