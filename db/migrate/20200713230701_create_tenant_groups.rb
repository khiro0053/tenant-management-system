class CreateTenantGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :tenant_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
