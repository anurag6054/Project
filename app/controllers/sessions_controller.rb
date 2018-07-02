#Handles routes related to session management
class SessionsController < ApplicationController

  #create a new session, redirect to main application page
  def create
    @user = User.find_or_create_from_auth_hash(env["omniauth.auth"])
    session[:user_id] = @user.id
    redirect_to customers_main_path
  end

  #set current session to nil, redirect to logout page
  def destroy
    session[:user_id] = nil
    redirect_to pages_logout_path
  end
end
