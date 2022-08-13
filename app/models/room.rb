# == Schema Information
#
# Table name: rooms
#
#  id               :bigint           not null, primary key
#  name             :string(255)
#  seating_capacity :integer
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#  tenant_id        :bigint
#
# Indexes
#
#  index_rooms_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#
class Room < ApplicationRecord
  validates :name, presence: true, length: { maximum: 20 }
  validates :seating_capacity, presence: true
  belongs_to :tenant
  has_many :room_assingments, dependent: :nullify
  has_many :residents, through: :room_assingments
end
