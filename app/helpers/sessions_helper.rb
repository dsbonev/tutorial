module SessionsHelper

  def sign_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:remember_token] = remember_token
    user.update_attribute :remember_token, User.digest(remember_token)
    self.current_user = user
  end

  def sign_out
    remember_token = User.digest User.new_remember_token
    current_user.update_attribute :remember_token, remember_token
    cookies.delete :remember_token
    self.current_user = nil
  end

  def signed_in?
    current_user.present?
  end

  def current_user=(user)
    @current_user = user
  end

  def current_user
    @current_user ||= find_current_user
  end

  def find_current_user
    remember_token = User.digest cookies[:remember_token]
    User.find_by remember_token: remember_token
  end
end
