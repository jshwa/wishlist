module CategoriesHelper
  def category_top_users(category)
    category.users.collect do |user|
      user if user.most_popular_categories.include?(category)
    end.uniq
  end

  def display_side_az_list
    al = ('A'..'Z').collect do |letter|
      tag.nav class:'side_list', id:letter do
        if list_links[letter]
          l = list_links[letter].collect do |link|
            link[1]
          end
          l[0]
        end
      end
    end
    raw al.join
  end

  def list_links
    links = Hash.new
    @categories.each do |category|
      if links[category.name.slice(0)].blank?
        links[category.name.slice(0)] = Hash.new
        links[category.name.slice(0)][0] = link_to category.name, category_path(category), class:"category-link"
      else
        num = 0
        while links[category.name.slice(0)][num] != nil do
          num += 1
        end
        links[category.name.slice(0)][num] = Hash.new
        links[category.name.slice(0)][num] = link_to category.name, category_path(category), class:"category-link"
      end
    end
    links
  end
end
