class Review < ApplicationRecord
  belongs_to :user
  belongs_to :gift
  validates :stars, presence: :true

  def display_rating
    rating = ""
    stars.times { rating += "<i class='fa fa-star' aria-hidden='true'></i>"}
    rating.html_safe
  end
end
