class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :name
      t.string :phone_number
      t.boolean :is_active
      t.string :password
      t.references :role, null: false, foreign_key: true

      t.timestamps
    end
  end
end
