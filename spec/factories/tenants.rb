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
#  area_id                    :bigint
#  company_id                 :bigint
#
# Indexes
#
#  index_tenants_on_area_id     (area_id)
#  index_tenants_on_company_id  (company_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#  fk_rails_...  (company_id => companies.id)
#

FactoryBot.define do
  factory :tenant do
    capacity { Random.new.rand(18..300) }
    name { Faker::Company.name }
    target_number_of_residents { 18 }
    area
    company
  end
end
