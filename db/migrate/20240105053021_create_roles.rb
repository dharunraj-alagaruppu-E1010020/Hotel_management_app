class CreateRoles < ActiveRecord::Migration[7.1]
  def change
    create_table :roles do |t|
      t.bigint :role_id
      t.string :role

      t.timestamps
    end
  end
end
