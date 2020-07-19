class CreateResidents < ActiveRecord::Migration[5.2]
  def change
    create_table :residents do |t|
      t.string :name
      t.string :nursing_care_level
      t.date :start_date
      t.date :end_date
      t.string :resident_state

      t.timestamps
    end
  end
end
