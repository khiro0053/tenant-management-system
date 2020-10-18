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
class Tenant < ApplicationRecord
  validates :name, presence: true, length: { in: 1..50 }
  validates :capacity, presence: true
  validate :target_number_of_residents_cannot_be_greater_than_capacity

  def target_number_of_residents_cannot_be_greater_than_capacity
    self.target_number_of_residents ||= 0
    self.capacity ||= 0
    if self.target_number_of_residents > self.capacity
      errors.add(:target_number_of_residents, "定員数を上回る目標は設定できません")
    end
  end


  has_many :rooms, dependent: :destroy
  has_many :residents, dependent: :restrict_with_exception
  belongs_to :company
  belongs_to :area
end
