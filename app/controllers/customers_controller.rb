#Handles routes related to customers and related records
class CustomersController < ApplicationController
  #Ensure that user is logged in and authorized to access Customer views
  before_action :authenticate, :authorize

  #Main application view
  def main
  end
end
