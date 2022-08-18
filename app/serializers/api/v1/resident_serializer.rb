class Api::V1::ResidentSerializer < ActiveModel::Serializer
  attributes :id, :care_level, :first_name, :last_name, :is_hospitalized
  belongs_to :tenant
end
