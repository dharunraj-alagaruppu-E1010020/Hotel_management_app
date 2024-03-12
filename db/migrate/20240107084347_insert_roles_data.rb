class InsertRolesData < ActiveRecord::Migration[7.1]
  def change
    Role.create(name: 'admin')
    Role.create(name: 'user')
  end
end
