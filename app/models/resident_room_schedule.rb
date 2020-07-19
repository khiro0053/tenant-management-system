class ResidentRoomSchedule < ApplicationRecord
  belongs_to :resident
  belongs_to :room
  belongs_to :tenant
end
