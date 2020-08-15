# == Schema Information
#
# Table name: residents
#
#  id              :bigint           not null, primary key
#  care_level      :string(255)      default("jiritu")
#  first_name      :string(255)
#  is_hospitalized :boolean          default(FALSE), not null
#  last_name       :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  tenant_id       :bigint
#
# Indexes
#
#  index_residents_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#
class Resident < ApplicationRecord
  validates :first_name, presence: true, length: { in: 1..20 }
  validates :last_name, presence: true, length: { in: 1..20 }
  enum care_level: {
    jiritu: "自立",
    youshien1: "要支援１",
    youshien2: "要支援２",
    youkaigo1: "要介護１",
    youkaigo2: "要介護２",
    youkaigo3: "要介護3",
    youkaigo4: "要介護4",
    youkaigo5: "要介護5",
  }

  belongs_to :tenant
  has_many :room_assingments, dependent: :destroy
  has_many :room, through: :room_assingments
end
