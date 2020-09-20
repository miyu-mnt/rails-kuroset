class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :success, :info, :warning, :danger
  
  helper_method :current_user, :logged_in?, :log_in
  
  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
  
  def log_in(user)
    session[:user_id] = user.id
  end
  
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  def authenticate_user
    if current_user == nil
      redirect_to root_path, success: 'ログインしてください'
    end
  end
  
  def forbid_login_user
    if current_user
      redirect_to topics_path, success: 'ログイン済みのユーザーです'
    end
  end
  
end