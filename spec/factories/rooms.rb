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
#  index_rooms_on_name       (name) UNIQUE
#  index_rooms_on_tenant_id  (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#
FactoryBot.define do
  factory :room do
    name { Random.new.rand(1..300).to_s + "号室" }
    seating_capacity { Random.new.rand(1..2) }
    tenant
  end
end
