class Public::OrdersController < ApplicationController

  before_action :new_order_check

  def new
    @addresses = current_customer.addresses || []
  end

  def check
    @cart_items = CartItem.where(customer_id:current_customer.id)
    @shipping_cost = 800
    @payment_method = Order.payment_methods_i18n[params[:order][:payment_method].to_sym]
    @total_cart_price = current_customer.total_cart_price
    @total_payment = @total_cart_price + @shipping_cost
    @address = params[:order][:address]
    case @address
    when "customer_address"
      @selected_address = "〒" + current_customer.postal_code + " " + current_customer.address
      @selected_name = current_customer.last_name + current_customer.first_name
    when "registred_address"
      unless params[:order][:address_id] == " "
        selected = Adress.find(params[:order][:address_id])
        @selected_address = "〒" +selected.postal_code + " " + selected.address
        @selected_name = selected.name
      else
        render :new
      end
    when "new_address"
      unless params[:order][:new_postal_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
        @selected_address = "〒" + params[:order][:new_postal_code] + "" + params[:order][:new_address]
        @selected_name = params[:order][:new_name]
      else
        render :new
      end
    end
  end

  def create
    @cart_items =CartItem.where(customer_id:[current_customer.id])
    @order = Order.new(order_params)
    @postage = 800
    
  end

  def complete
  end

    

  def create
  end

  def index
  end

  def show
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :address, :total_payment,:name,:payment_method, :shipping_cost, :status, :postage, :payment)
  end

  def new_order_check
    if current_customer.cart_items.empty?
      redirect_to root_path, alert: "カートが空です。商品を追加してください。"
    end
  end

end
