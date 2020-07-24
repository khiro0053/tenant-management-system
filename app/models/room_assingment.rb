class RoomAssingment < ApplicationRecord
  belongs_to :resident
  belongs_to :room
end
