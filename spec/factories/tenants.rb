# == Schema Information
#
# Table name: tenants
#
#  id                         :bigint           not null, primary key
#  capacity                   :integer
#  name                       :string(255)
#  target_number_of_residents :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  company_id                 :bigint
#  tenant_group_id            :bigint
#
# Indexes
#
#  index_tenants_on_company_id       (company_id)
#  index_tenants_on_tenant_group_id  (tenant_group_id)
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#  fk_rails_...  (tenant_group_id => tenant_groups.id)
#

FactoryBot.define do
  factory :tenant do
    capacity { Random.new.rand(18..300) }
    name { Faker::Company.name }
    target_number_of_residents { 18 }
    company
  end
end
