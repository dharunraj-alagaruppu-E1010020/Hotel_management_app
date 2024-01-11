class TableRestaurant < ApplicationRecord
  belongs_to :restaurant

  validates_uniqueness_of :table_number, scope: :restaurant_id
end
