#ActiveRecord model for Master.Location table
class Location < ActiveRecord::Base
  self.table_name = "Master.Location"
  has_many :customer_locations, foreign_key: "Location_ClusterID"
end
