class List < ApplicationRecord
  belongs_to :user
  has_many :list_gifts
  has_many :gifts, through: :list_gifts
  has_many :categories, through: :gifts
end
