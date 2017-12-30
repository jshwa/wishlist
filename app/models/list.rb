class List < ApplicationRecord
  belongs_to :user
  has_many :wish_gifts
  has_many :gifts, through: :wish_gifts
  has_many :categories, through: :gifts
end
