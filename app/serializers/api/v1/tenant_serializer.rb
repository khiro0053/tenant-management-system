class Api::V1::TenantSerializer < ActiveModel::Serializer
  attributes :id, :name, :target_number_of_residents
  belongs_to :area
end
