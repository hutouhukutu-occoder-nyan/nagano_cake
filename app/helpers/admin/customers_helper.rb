module Admin::CustomersHelper

  def customer_status(customer)
    customer.is_active ? '有効' : '退会'
  end
  
end
