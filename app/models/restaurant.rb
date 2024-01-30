class Restaurant < ApplicationRecord

  self.table_name = 'restaurants'

  belongs_to :user
  has_many :table_bookings

  def delete_restaurant(restaurant_id)
    rest_obj = Restaurant.find_by(id: restaurant_id)
    
    if rest_obj
      rest_obj.update(is_active: false)
      puts "Restaurant delete successfully"
      return true  
    else
      return false 
    end
  end
    
end
