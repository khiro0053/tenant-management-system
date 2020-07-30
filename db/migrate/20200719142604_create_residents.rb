class CreateResidents < ActiveRecord::Migration[5.2]
  def change
    create_table :residents do |t|
      t.string :first_name
      t.string :last_name
      t.string :is_hospitalized
      t.references :tenant, foreign_key: true
      t.references :care_level, foreign_key: true

      t.timestamps
    end
  end
end
