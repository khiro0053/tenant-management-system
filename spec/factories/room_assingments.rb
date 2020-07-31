# == Schema Information
#
# Table name: room_assingments
#
#  id          :bigint           not null, primary key
#  date_from   :date
#  date_to     :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  resident_id :bigint
#  room_id     :bigint
#
# Indexes
#
#  index_room_assingments_on_resident_id  (resident_id)
#  index_room_assingments_on_room_id      (room_id)
#
# Foreign Keys
#
#  fk_rails_...  (resident_id => residents.id)
#  fk_rails_...  (room_id => rooms.id)
#
FactoryBot.define do
  factory :room_assingment do
    scheduled_move_in_date { "2020-07-19" }
    scheduled_departure_date { "2020-07-19" }
    resident { nil }
    room { nil }
    tenant { nil }
  end
end
