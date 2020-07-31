# == Schema Information
#
# Table name: care_levels
#
#  id         :bigint           not null, primary key
#  care_level :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :care_level do
    care_level { "MyString" }
  end
end
