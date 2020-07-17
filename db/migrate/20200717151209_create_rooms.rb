class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.string :name
      t.intger :seating_capacity
      t.string :vacancy_flag

      t.timestamps
    end
  end
end
