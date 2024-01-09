class InsertRolesData < ActiveRecord::Migration[7.1]
  def change
    Role.create(role: 'admin')
    Role.create(role: 'user')
  end
end
