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
class RoomAssingment < ApplicationRecord
  validates :date_from, presence: true
  validate  :date_to_not_before_date_from

  def date_to_not_before_date_from
    if self.date_to.present? && self.date_to < self.date_from
      errors.add(:date_to, "契約開始日より前の日付は入力できません。")
    end
  end

  belongs_to :resident
  belongs_to :room
end
