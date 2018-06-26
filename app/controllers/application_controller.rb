class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  #Checks whether user is signed in and redirects to signin page if not
  def authenticate
    if !user_signed_in?
      flash[:danger] = t('application.authentication.not_signed_in')
      redirect_to pages_login_path
    end
  end

  #Checks whether user email exists in authorized_users table
  def authorize
    if !user_authorized?
      flash[:danger] = t('application.authorization.not_authorized')
      redirect_to pages_unauthorized_path
    end
  end

  #Finds session for current user, if exists
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  #Checks whether user is signed in
  def user_signed_in?
    !!current_user
  end

  #Checks whether current user exists in authorized_users table
  def user_authorized?
    AuthorizedUser.find_by_email(current_user.email)
  end
end
