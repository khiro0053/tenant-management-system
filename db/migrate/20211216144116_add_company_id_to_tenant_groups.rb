class AddCompanyIdToTenantGroups < ActiveRecord::Migration[5.2]
  def change
    add_reference :tenant_groups, :company, foreign_key: true
  end
end
