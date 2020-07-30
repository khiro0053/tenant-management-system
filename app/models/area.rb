class Area < ApplicationRecord
  has_many :tenants, dependent: :nullify
end
