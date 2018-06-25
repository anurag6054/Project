class CustomerLocation < ActiveRecord::Base
  self.table_name = "Master.Customer_Location"
  has_one :location, foreign_key: "ClusterID"
  has_one :customer, foreign_key: "ClusterID"
  has_many :work_orders, foreign_key: "LocationClusterID"
end
