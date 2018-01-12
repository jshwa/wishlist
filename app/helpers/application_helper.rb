module ApplicationHelper

  def show_errors
    unless request.path == "/users/sign_in"
      if flash[:notice] || flash[:alert]
        "<p class='notice'>#{notice}</p>"
        "<p class='alert'>#{alert}</p>"
      end.try(:html_safe)
    end
  end
end
