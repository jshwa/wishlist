class ReviewSerializer < ActiveModel::Serializer
  attributes :id, :stars, :comment, :gift_id, :updated_at
  belongs_to :user
end
