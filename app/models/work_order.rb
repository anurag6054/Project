class WorkOrder < ActiveRecord::Base
  self.table_name = "Master.Workorders"
  has_one :customer_location, foreign_key: "Location_ClusterID"
end
