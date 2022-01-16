class AddIndexToTenantGroups < ActiveRecord::Migration[5.2]
  def change
    add_index :tenant_groups, :name, unique: true
  end
end
