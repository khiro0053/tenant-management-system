class CreateRoomAssingments < ActiveRecord::Migration[5.2]
  def change
    create_table :room_assingments do |t|
      t.date :date_from
      t.date :date_to
      t.references :resident, foreign_key: true
      t.references :room, foreign_key: true

      t.timestamps
    end
  end
end
