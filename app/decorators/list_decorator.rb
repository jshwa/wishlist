class ListDecorator < Draper::Decorator
  delegate_all

  def display_users
    h.content_tag :li do
      h.concat h.link_to_if list.user != h.current_user, (h.image_tag list.user.image), h.list_path(list)
      h.concat h.link_to_if list.user != h.current_user, list.user.username, h.list_path(list)
    end
  end

end
