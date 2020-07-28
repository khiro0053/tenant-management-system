class CareLevel < ApplicationRecord
  has_many :residents, dependent: :nullify
end
