module ReviewsHelper

  def formatted_updated_at(review)
    review.updated_at.strftime("%b %d, %Y")
  end
end
