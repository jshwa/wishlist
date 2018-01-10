class Category < ApplicationRecord
  has_many :category_gifts
  has_many :gifts, through: :category_gifts
  has_many :lists, through: :gifts
  validates :name, presence: :true, uniqueness: :true
end
