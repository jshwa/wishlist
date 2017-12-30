class Gift < ApplicationRecord
  has_many :list_gifts
  has_many :lists, through: :list_gifts
  has_many :users, through: :lists
  has_many :category_gifts
  has_many :categories, through: :category_gifts
end
