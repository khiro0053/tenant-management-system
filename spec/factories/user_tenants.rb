# == Schema Information
#
# Table name: user_tenants
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  tenant_id  :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_user_tenants_on_tenant_id  (tenant_id)
#  index_user_tenants_on_user_id    (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (tenant_id => tenants.id)
#  fk_rails_...  (user_id => users.id)
#
FactoryBot.define do
  factory :user_tenant do
    user
    tenant
  end
end
