class GiftSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :image, :price, :url, :on_list

  def on_list
    current_user.list.gifts.include?(object)
  end

end
