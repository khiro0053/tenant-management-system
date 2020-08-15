# == Schema Information
#
# Table name: areas
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_areas_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :area do
    name { Faker::Address.state }
  end
end
