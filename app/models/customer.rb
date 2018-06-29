#ActiveRecord model for Master.Customer table
class Customer < ActiveRecord::Base
  self.table_name = "Master.Customer"
  has_many :customer_locations, foreign_key: "Customer_ClusterID"
  has_many :services, foreign_key: "Customer_ClusterID"
  has_many :rounds, through: :services
  has_many :work_orders, through: :customer_locations
  has_many :locations, through: :customer_locations

  def export_pre_migration_data
    @customers_by_groupaccount = Customer.where(GroupAccount: self.GroupAccount)

    #TODO update to check for actual success/failure
    if true
      message = { "status" => "success", "message" => I18n.t('customer.export_pre_migration_data_success') }
    else
      message = { "status" => "success", "message" => I18n.t('customer.export_pre_migration_data_failure') }
    end
  end

  def export_post_migration_data

    #TODO update to check for actual success/failure
    if true
      message = { "status" => "success", "message" => I18n.t('customer.export_post_migration_data_success') }
    else
      message = { "status" => "success", "message" => I18n.t('customer.export_post_migration_data_failure') }
    end
  end

  def set_migration_flag

    #TODO update to check for actual success/failure
    if true
      message = { "status" => "success", "message" => I18n.t('customer.update_customer_name_success') }
    else
      message = { "status" => "success", "message" => I18n.t('customer.update_customer_name_failure') }
    end
  end

  def update_customer_name

    #TODO update to check for actual success/failure
    if true
      message = { "status" => "success", "message" => I18n.t('customer.set_migration_flag_success') }
    else
      message = { "status" => "success", "message" => I18n.t('customer.set_migration_flag_failure') }
    end
  end



end
