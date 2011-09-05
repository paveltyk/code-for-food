# encoding: utf-8

module UsersHelper
  def user_nav
    links = []
    if current_user
      links << current_user.email
      if is_admin?
        links << link_to('Пользователи', admin_users_path, :id => 'user-nav-users', :title => 'Список всех пользователей')
        links << link_to('Метки', admin_dish_tags_path, :id => 'user-nav-tags', :title => 'Все метки туц туц туц! Ту-ду-дуц туц туц!')
      end
      links << link_to('Общение', questions_path, :id => 'user-nav-forum', :title => 'Общайся туц туц туц! Ту-ду-дуц туц туц!')
      links << link_to('Мой баланс', balance_path, :id => 'user-nav-balance', :title => 'Остаток на счету')
      links << link_to('Изменить профиль', edit_profile_path, :id => 'user-nav-profile', :title => 'Редактировать мой профиль')
      links << link_to('Выйти', logout_path, :id => 'user-nav-logout', :title => 'Выход')
    else
      links << link_to('Войти', login_path, :id => 'user-nav-login', :title => 'Вход')
    end
    content_tag :ul, links.map { |link| content_tag :li, link }.join(content_tag :li, '|', :class => 'separator').html_safe, :id => 'user-nav'
  end
end

