class AddUniqueConstraintToPhoneNumberInUser < ActiveRecord::Migration[7.1]
  def change
    add_index :user, :phone_number, unique: true
  end
end
