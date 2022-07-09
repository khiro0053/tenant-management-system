class Api::V1::RoomSerializer < ActiveModel::Serializer
  attributes :id, :name, :seating_capacity
  belongs_to :tenant
end
