class CategorySerializer < ActiveModel::Serializer
  attributes :id, :name
  has_many :gifts

  has_many :users do |serializer|
    object.users.where(id: serializer.top_users).distinct
  end

  def top_users
    object.users.collect do |user|
      user.id if user.most_popular_categories.include?(object)
    end.uniq
  end
end
