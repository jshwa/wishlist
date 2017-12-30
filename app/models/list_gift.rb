class ListGift < ApplicationRecord
  belongs_to :list
  belongs_to :gift
end
