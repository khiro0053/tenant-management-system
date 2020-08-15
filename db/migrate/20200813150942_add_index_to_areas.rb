class AddIndexToAreas < ActiveRecord::Migration[5.2]
  def change
    add_index :areas, :name, unique: true
  end
end
