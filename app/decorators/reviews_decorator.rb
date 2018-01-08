class ReviewsDecorator < Draper::CollectionDecorator

  def review_index_title(gift, user)
    gift ? "Reviews for: #{gift.name}" : "Reviews by #{user.username.humanize}"
  end

  def no_reviews(gift, user)
    if object.length == 0
      h.content_tag :div, class: "review_item" do
        if gift
          concat "<strong> #{gift.name} doesn't have any reviews. Be the first to write one! </strong>"
          concat h.button_to "Write a review", new_gift_review_path(gift), method: 'get', class:'big_btn'
        else
          "<strong> #{user.username.humanize} hasn't written any reviews.</strong>"
        end.html_safe
      end
    end
  end

end
