class CreateCareLevels < ActiveRecord::Migration[5.2]
  def change
    create_table :care_levels do |t|
      t.string :care_level

      t.timestamps
    end
  end
end
