class CategoryGift < ApplicationRecord
  belongs_to :category
  belongs_to :gift
end
