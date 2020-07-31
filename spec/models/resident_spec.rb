# == Schema Information
#
# Table name: residents
#
#  id              :bigint           not null, primary key
#  first_name      :string(255)
#  is_hospitalized :string(255)
#  last_name       :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  care_level_id   :bigint
#  tenant_id       :bigint
#
# Indexes
#
#  index_residents_on_care_level_id  (care_level_id)
#  index_residents_on_tenant_id      (tenant_id)
#
# Foreign Keys
#
#  fk_rails_...  (care_level_id => care_levels.id)
#  fk_rails_...  (tenant_id => tenants.id)
#
require "rails_helper"

RSpec.describe Resident, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
