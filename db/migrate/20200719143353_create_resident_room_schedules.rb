class CreateResidentRoomSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :resident_room_schedules do |t|
      t.date :scheduled_move_in_date
      t.date :scheduled_departure_date
      t.references :resident, foreign_key: true
      t.references :room, foreign_key: true
      t.references :tenant, foreign_key: true

      t.timestamps
    end
  end
end
