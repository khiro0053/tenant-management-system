class CreateTenants < ActiveRecord::Migration[5.2]
  def change
    create_table :tenants do |t|
      t.string :name
      t.integer :target_number_of_residents
      t.string :area

      t.timestamps
    end
  end
end
