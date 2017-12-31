class Gift < ApplicationRecord
  has_many :list_gifts
  has_many :lists, through: :list_gifts
  has_many :users, through: :lists
  has_many :category_gifts
  has_many :categories, through: :category_gifts

  def categories_attributes=(categories_attributes)
    categories_attributes.each do |i, cat_attr|
      self.categories << (Category.find_or_create_by(name: cat_attr[:name]))
    end
  end
end
