# encoding: utf-8

class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user_session, :current_user, :is_admin?

  private

  def is_admin?
    current_user && current_user.instance_of?(Administrator)
  end

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "Вам необходимо войти в систему."
      redirect_to login_url
    end
  end

  def require_admin
    unless current_user && current_user.instance_of?(Administrator)
      store_location
      flash[:notice] = "Вам необходимо войти в систему как администратор."
      redirect_to login_url
    end
  end

  def store_location
    session[:return_to] = request.fullpath
  end

  def redirect_back_or_default(default)
    redirect_to session[:return_to] || default
    session[:return_to] = nil
  end
end

