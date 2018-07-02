#Handles static pages
class PagesController < ApplicationController

  def login
    if session[:user_id]
      redirect_to customers_main_path
    end
  end

  def logout
  end

  def unauthorized
  end
end
