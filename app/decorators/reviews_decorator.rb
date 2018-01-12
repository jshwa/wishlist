class ReviewsDecorator < Draper::CollectionDecorator

  def review_index_title(gift, user)
    gift ? "Reviews for: #{gift.name}" : "Reviews by #{user.username.humanize}"
  end

  def no_reviews(gift, user)
    if object.length == 0
      h.tag.div class: "review_item" do
        if gift
          h.concat h.content_tag :strong, "#{gift.name} doesn't have any reviews. Be the first to write one!"
          h.concat h.button_to "Write a review", h.new_gift_review_path(gift), method:'get', class:'big_btn'
        else
          "<strong> #{user.username.humanize} hasn't written any reviews.</strong>"
        end.html_safe
      end
    else
      if gift && h.current_user && !h.current_user.wrote_a_review?(gift)
        h.button_to "Write a review", h.new_gift_review_path(gift), method:'get', class:'big_btn'
      end
    end
  end

end
