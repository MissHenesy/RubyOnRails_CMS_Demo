module ApplicationHelper
  def user_greeting_name
    current_user.first_name.blank? ? current_user.email : current_user.first_name
  end

end
