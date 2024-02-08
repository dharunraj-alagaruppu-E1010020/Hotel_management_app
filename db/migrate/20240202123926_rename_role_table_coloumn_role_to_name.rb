class RenameRoleTableColoumnRoleToName < ActiveRecord::Migration[7.1]
  def change
    rename_column :roles, :role, :name
  end
end
