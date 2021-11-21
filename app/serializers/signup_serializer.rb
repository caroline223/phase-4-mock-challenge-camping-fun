class SignupSerializer < ActiveModel::Serializer
  attributes :id, :camper_id, :activity_id, :time

  belongs_to :camper 
  belongs_to :activity
end
 