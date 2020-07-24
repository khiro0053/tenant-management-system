class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.intger :seating_capacity
      t.references :tenant, foreign_key:true

      t.timestamps
    end
  end
end
