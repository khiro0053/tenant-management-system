class Tenant < ApplicationRecord
  has_many :user_tenants, dependent: :destroy
  has_many :users, through: :user_tenants
  has_many :rooms, dependent: :destroy
  has_many :residents, dependent: :restrict_with_exception
  belongs_to :area
end
