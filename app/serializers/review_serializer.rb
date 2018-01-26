class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :stars, :comment, :user_id, :gift_id
end
