module CategoriesHelper
  def category_top_users(category)
    category.users.collect do |user|
      user if user.most_popular_categories.include?(category)
    end.uniq
  end
end
