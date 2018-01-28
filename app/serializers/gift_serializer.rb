class GiftSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :price
end
