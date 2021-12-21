# == Schema Information
#
# Table name: tenant_groups
#
#  id         :bigint           not null, primary key
#  name       :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint
#
# Indexes
#
#  index_tenant_groups_on_company_id  (company_id)
#  index_tenant_groups_on_name        (name) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (company_id => companies.id)
#
class TenantGroup < ApplicationRecord
  validates :name, presence: true, uniqueness: true, length: { in: 1..30 }
  has_many :tenants, dependent: :nullify
  belongs_to :company
end
