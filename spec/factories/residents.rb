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
FactoryBot.define do
  factory :resident do
    name { "MyString" }
    nursing_care_level { "MyString" }
    start_date { "2020-07-19" }
    end_date { "2020-07-19" }
    resident_state { "MyString" }
  end
end
