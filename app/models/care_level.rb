# == Schema Information
#
# Table name: care_levels
#
#  id         :bigint           not null, primary key
#  care_level :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class CareLevel < ApplicationRecord
  validates :care_level,  uniqueness: true
  has_many :residents, dependent: :nullify
end
