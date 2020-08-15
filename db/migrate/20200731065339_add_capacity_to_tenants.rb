class AddCapacityToTenants < ActiveRecord::Migration[5.2]
  def change
    add_column :tenants, :capacity, :integer
  end
end
