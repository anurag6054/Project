#ActiveRecord model for Master.Round table
class Round < ActiveRecord::Base
  self.table_name = "Master.Round"
  has_one :service, foreign_key: "KADROCustomerID"
  has_many :customers, through: :services
end
