#Handles routes related to customers and related records
class CustomersController < ApplicationController
  include CustomersHelper
  #Ensure that user is logged in and authorized to access Customer views
  before_action :authenticate, :authorize

  def main
  end

  def search
    @customer = Customer.find_by_BillToID_and_EndDate(params[:search],"99991231")
    render :main
  end

  def export
    @customer = Customer.find_by_BillToID_and_EndDate(params[:customer][:BillToID],"99991231")

    if params[:customer]
      if params[:export_pre_migration_data]
        message = @customer.export_pre_migration_data
      elsif params[:export_post_migration_data]
        message = @customer.export_post_migration_data
      elsif params[:set_migration_flag]
        message = @customer.set_migration_flag
      elsif params[:update_customer_name]
        message = @customer.update_customer_name
      end

      get_alert(message)

      redirect_to customers_search_path(:search => @customer.BillToID)
    end
  end
end
