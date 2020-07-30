FactoryBot.define do
  factory :room_assingment do
    scheduled_move_in_date { "2020-07-19" }
    scheduled_departure_date { "2020-07-19" }
    resident { nil }
    room { nil }
    tenant { nil }
  end
end
