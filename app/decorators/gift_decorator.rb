class GiftDecorator < Draper::Decorator
  delegate_all

  def add_a_button
    if h.current_user && h.current_user.gifts.include?(gift)
      h.button_to "On Your Wishlist", h.list_path(current_user.list), method: 'get', class: 'item_button'
    else
      h.form_for gift, url: h.gift_path(gift), html: {method: "patch"} do |g|
        g.submit "Add to Wishlist", class:'item_button'
    end
    end
  end
end
