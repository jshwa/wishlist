class CategoryGift < ApplicationRecord
  belongs_to :category
  belongs_to :gift
  validates :gift, :category, presence: :true
end
