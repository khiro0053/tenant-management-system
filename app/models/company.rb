# == Schema Information
#
# Table name: companies
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Company < ApplicationRecord
  validates :name, presence: true, length: { maximum: 30 }
  has_many :tenants, dependent: :restrict_with_error
  has_many :tenant_groups, dependent: :restrict_with_error
  has_many :users, dependent: :restrict_with_error
end
