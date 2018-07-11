module CustomersHelper
  def get_alert(message)
    if message["status"] == "success"
      flash[:success]=message["message"]
    else
      flash[:danger]=message["message"]
    end
  end
end
