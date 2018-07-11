#ActiveRecord model for Master.Customer table
class Customer < ActiveRecord::Base
  self.table_name = "Master.Customer"
  has_many :customer_locations, foreign_key: "Customer_ClusterID"
  has_many :services, foreign_key: "Customer_ClusterID"
  has_many :rounds, through: :services
  has_many :work_orders, through: :customer_locations
  has_many :locations, through: :customer_locations

  def export_pre_migration_data
    @customers_by_groupaccount = Customer.select([Database], ClusterID as Customer_ClusterID, GroupAccount 
			,BillToID, BillToCode, Company_Clean, [Address], City, [State]
			, StrategicAccountCustomerName, StrategicAccountGroupAccount
			, IsUpdatedOB360, EndDate, IsReadyForIntegration)
                                .where(GroupAccount: self.GroupAccount)
                                .order(Company_Clean)
    
    respond_to do |format|
      format.html
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; 
        filename="Bill_by_all_GroupAccounts.xlsx"'
                  }                                                      

    @customers_by_companyclean = CustomerFinal.select([Database], ClusterID as Customer_ClusterID,
                                GroupAccount, BillToID, BillToCode, Company_Clean)
                                .where(CompanyClean: self.Company_Clean)
                                .order(Company_Clean) 
                                
    respond_to do |format|
      format.html
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; 
        filename="Bill_by_CompanyName.xlsx"'
                  }                             

    @customers_by_currentaccount = Customer.select([Database], ClusterID as Customer_ClusterID, GroupAccount 
			,BillToID, BillToCode, Company_Clean, [Address], City, [State]
			, StrategicAccountCustomerName, StrategicAccountGroupAccount
			, IsUpdatedOB360, EndDate, IsReadyForIntegration)
                                      .where(ClusterID: self.Customer_ClusterID)

    respond_to do |format|
      format.html
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; 
        filename="Accounts.xlsx"'
                  }      
    
    @locations = CustomerLocation.select(ClusterID, PrimaryDatabase, Company, BillToID, IndustryType, [Address]
			, Address2, City, [State], County, Zip, Country, Phone, StoreNumber, FSID
			, PrimaryLocationID, PrimaryLocationCode, LocationSourceSystem)
    .joins(Master.Location).where(Customer_ClusterID: self.Customer_ClusterID)
    .order(Company)

    respond_to do |format|
      format.html
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; 
        filename="Locations.xlsx"'
                  } 

    @services = Service.select(LocationServiceSetupFSID,ServiceDescription,IsPrimaryService,KADROCustomerID
      ,KADROCustomerID,KADROOrganizationID,KADROOrganizationName)
      .where(Customer_ClusterID: self.Customer_ClusterID)

      respond_to do |format|
        format.html
        format.xlsx{
          response.headers['Content-Disposition'] = 'attachment; 
          filename="Services.xlsx"'
                    }   

    @rounds = Round.joins (Master.Service).where(Service.Customer_ClusterId
      : self.Customer_ClusterId).order(Round.RoundStart: :desc)

    respond_to do |format|
      format.html
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; 
        filename="Rounds.xlsx"'
                  } 

    @workorders = WorkOrder.joins (master.Customer_Location).joins (Master.Location).
      .joins(Master.Round) 
      .joins(Master.Service as S)
      .where(S.Customer_ClusterID : self.Customer_ClusterID)
      .where(WorkOrder.ScheduledDate > GETDATE())
      .order(WorkOrder.ScheduledDate: :desc).uniq

    respond_to do |format|
      format.html
      format.xlsx{
        response.headers['Content-Disposition'] = 'attachment; 
        filename="Work Orders.xlsx"'
                  } 
    if true
      message = { "status" => "success", "message" => I18n.t('customer.export_pre_migration_data_success') }
    else
      message = { "status" => "success", "message" => I18n.t('customer.export_pre_migration_data_failure') }
    end
  end

  def export_post_migration_data

    #TODO build queries to mirror export post-migration data stored procedures

    #TODO use Axlsx library to export query output to Excel

    #TODO update to check for actual success/failure
    if true
      message = { "status" => "success", "message" => I18n.t('customer.export_post_migration_data_success') }
    else
      message = { "status" => "success", "message" => I18n.t('customer.export_post_migration_data_failure') }
    end
  end

  def set_migration_flag

    #TODO build queries to mirror set migration flag stored procedure

    #TODO update to check for actual success/failure
    if true
      message = { "status" => "success", "message" => I18n.t('customer.set_migration_flag_success') }
    else
      message = { "status" => "success", "message" => I18n.t('customer.set_migration_flag_failure') }
    end
  end

  def update_customer_name
    begin

    rescue
    end
    #TODO build query to update customer name

    #TODO update to check for actual success/failure
    if true
      message = { "status" => "success", "message" => I18n.t('customer.update_customer_name_success') }
    else
      message = { "status" => "success", "message" => I18n.t('customer.update_customer_name_failure') }
    end
  end

end
