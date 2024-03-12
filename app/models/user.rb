class User < ApplicationRecord
  
  belongs_to :role
  has_many :restaurants
  has_many :table_bookings
  validates_uniqueness_of :phone_number, scope: :role_id
  
  validates :name, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
  validates :phone_number, format: { with: /\A\d{10}\z/, message: "should be a 10-digit number" }
  validates :password, length: { minimum: 6, message: "should be at least 6 characters long" }
  validates :password, format: { with: /\A(?=.*[a-zA-Z])(?=.*\d)[a-zA-Z\d]+\z/, message: "should include at least one letter and one digit" }
  
  def phone_number_valid?
    phone_number =~ /\A\d{10}\z/
  end

  def display_name
    "#{name}"
  end
    
end