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
#
# Indexes
#
#  index_tenants_on_area_id  (area_id)
#
# Foreign Keys
#
#  fk_rails_...  (area_id => areas.id)
#
class Tenant < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }

  has_many :user_tenants, dependent: :destroy
  has_many :users, through: :user_tenants
  has_many :rooms, dependent: :destroy
  has_many :residents, dependent: :restrict_with_exception
  belongs_to :area
end
