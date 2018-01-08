class ReviewsDecorator < Draper::CollectionDecorator

  def review_index_title(gift, user)
    gift ? "Reviews for: #{gift.name}" : "Reviews by #{user.username.humanize}"
  end
end
