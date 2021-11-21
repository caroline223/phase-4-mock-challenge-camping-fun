class ActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :difficulty

  has_many :campers, through: :signups
end
