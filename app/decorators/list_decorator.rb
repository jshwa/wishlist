class ListDecorator < Draper::Decorator
  delegate_all

  def display_users
    if list.user != h.current_user
      h.content_tag :li do
        h.concat h.link_to (h.image_tag list.user.image), h.list_path(list)
        h.concat h.link_to list.user.username.humanize, h.list_path(list)
      end
    end
  end

end
