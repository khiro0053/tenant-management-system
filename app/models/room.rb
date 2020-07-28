class Room < ApplicationRecord
  belongs_to :tenant
  has_many :room_assingments, dependent: :nullify
  has_many :residents, through: :room_assingments
end
