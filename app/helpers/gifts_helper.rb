module GiftsHelper

  def shorten_name(name)
    if name.length > 150
      name_arr = name.reverse.split("").slice_when {|char| char =~ /[\,\.\-]/}.to_a
      name_arr.shift
      shorten_name(name_arr.flatten.reverse.join(""))
    else
      name
    end
  end

  def add_a_button(gift)
    if current_user && current_user.gifts.include?(gift)
      button_to "On Your Wishlist", list_path(current_user.list), method: 'get', class: 'item_button_added'
    else
      button_to "Add to Wishlist", gift_path(gift), method:'patch', class:'item_button'
    end
  end
end
