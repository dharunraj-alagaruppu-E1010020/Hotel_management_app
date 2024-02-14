class RemoveLastTwoColumnsFromRoles < ActiveRecord::Migration[7.1]
  def change
    remove_column :roles, :admin if column_exists?(:roles, :admin)
    remove_column :roles, :user if column_exists?(:roles, :user)
  end
end
