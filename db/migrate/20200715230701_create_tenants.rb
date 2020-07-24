class CreateTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants do |t|
      t.string :name
      t.integer :target_number_of_residents
      t.references :area, foreign_key: true

      t.timestamps
    end
  end
end
