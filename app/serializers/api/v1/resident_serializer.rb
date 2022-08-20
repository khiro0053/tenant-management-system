class Api::V1::ResidentSerializer < ActiveModel::Serializer
  attributes :id, :care_level, :full_name, :first_name, :last_name, :is_hospitalized
  belongs_to :tenant

  def full_name
    object.last_name + " " + object.first_name
  end
end
