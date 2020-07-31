# == Schema Information
#
# Table name: residents
#
#  id              :bigint           not null, primary key
#  first_name      :string(255)
#  is_hospitalized :string(255)
#  last_name       :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  care_level_id   :bigint
#  tenant_id       :bigint
#
# Indexes
#
#  index_residents_on_care_level_id  (care_level_id)
#  index_residents_on_tenant_id      (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (care_level_id => care_levels.id)
#  fk_rails_...  (tenant_id => tenants.id)
#
class Resident < ApplicationRecord
  belongs_to :tenant
  belongs_to :care_level
  has_many :room_assingments, dependent: :destroy
  has_many :room, through: :room_assingments
end
