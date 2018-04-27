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

  def add_a_wishlist_button(gift, button)
    if gift.persisted? && current_user && current_user.gifts.include?(gift)
      button_to "On Your Gift Guide", list_path(current_user.list), method: 'get', class: "#{button}_button_added"
    elsif gift.persisted?
      button_to "Add to Gift Guide", gifts_wishlist_path(gift), method:'patch', class:"#{button}_button"
    end
  end

  def display_results_helper(search_term)
    search_results = Amazonapi.search_results(search_term)
    search_results.dig("ItemSearchResponse", "Items", "Request", "Errors", "Error", "Message") ||
    search_results["ItemSearchResponse"]["Items"]["Item"].each do |item|
      if item.is_a?(Array)
        "Sorry, no results were found. Please try again."
      else
        new_gift = Gift.new_gift_from_amazon(item)
          yield(new_gift)
      end
    end
  end
end
