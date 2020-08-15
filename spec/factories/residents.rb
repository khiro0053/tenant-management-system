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
FactoryBot.define do
  factory :resident do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    is_hospitalized { false }
    care_level { "自立" }
    tenant

    trait :youkaigo5 do
      care_level { "要介護5" }
    end
  end
end
