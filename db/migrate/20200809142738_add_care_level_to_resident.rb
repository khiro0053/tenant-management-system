class AddCareLevelToResident < ActiveRecord::Migration[5.2]
  def change
    add_column :residents, :care_level, :string, default: "自立"
  end
end
