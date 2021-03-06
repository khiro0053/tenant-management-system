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
class Area < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 1..30 }
  has_many :tenants, dependent: :nullify
end
