class Api::V1::TenantSerializer < ActiveModel::Serializer
  attributes :id, :name, :capacity, :target_number_of_residents
  belongs_to :tenant_group
end
