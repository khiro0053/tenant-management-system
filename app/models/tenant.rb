class Tenant < ApplicationRecord
  has_many :user_tenants
  has_many :users, through: :user_tenants
  has_many :rooms
  has_many :residents
  belongs_to :area
end
