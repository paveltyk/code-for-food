module UsersHelper
  def user_nav
    links = []
    if current_user
      links << current_user.email
      if is_admin?
        links << link_to('Пользователи', admin_users_path)
        links << link_to('Метки', dish_tags_path)
      end
      links << link_to('Изменить профиль', edit_profile_path)
      links << link_to('Выйти', logout_path)
    else
      links << link_to('Войти', login_path)
    end
    content_tag :ul, links.map { |link| content_tag :li, link }.join(content_tag :li, '|', :class => 'separator').html_safe, :id => 'user-nav'
  end
end

