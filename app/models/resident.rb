class Resident < ApplicationRecord
  belongs_to :tenant
  belongs_to :care_level
  has_many :room_assingments
  has_many :room, through: :room_assingments
end
