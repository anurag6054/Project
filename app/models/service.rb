#ActiveRecord model for Master.Service table
class Service < ActiveRecord::Base
  self.table_name = "Master.Service"
  has_one :customer, foreign_key: "ClusterID"
  has_many :rounds, foreign_key: "CustomerID"
end
