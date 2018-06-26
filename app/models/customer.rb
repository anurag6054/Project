#ActiveRecord model for Master.Customer table
class Customer < ActiveRecord::Base
  self.table_name = "Master.Customer"
  has_many :customer_locations, foreign_key: "Customer_ClusterID"
  has_many :services, foreign_key: "Customer_ClusterID"
  has_many :rounds, through: :services
  has_many :work_orders, through: :customer_locations
  has_many :locations, through: :customer_locations
end
