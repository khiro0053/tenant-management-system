# == Schema Information
#
# Table name: tenants
#
#  id                         :bigint           not null, primary key
#  name                       :string(255)
#  target_number_of_residents :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#  area_id                    :bigint
#
# Indexes
#
#  index_tenants_on_area_id  (area_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#
FactoryBot.define do
  factory :tenant do
    name { "MyString" }
    target_number_of_residents { 1 }
    area { "MyString" }
  end
end
