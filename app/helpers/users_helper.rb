module UsersHelper
  def user_nav
    if current_user
      link_to 'Logout', logout_path
    else
      link_to 'Login', login_path
    end
  end
end

