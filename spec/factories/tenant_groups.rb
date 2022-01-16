# == Schema Information
#
# Table name: tenant_groups
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#
# Indexes
#
#  index_tenant_groups_on_company_id  (company_id)
#  index_tenant_groups_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
FactoryBot.define do
  factory :tenant_group do
    name { Faker::Address.state }
    company
  end
end
