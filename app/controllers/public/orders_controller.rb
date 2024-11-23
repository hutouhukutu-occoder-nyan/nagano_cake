class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  before_action :new_order_check, except: [:complete]

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
      @selected_postal_code =current_customer.postal_code
      @selected_address = current_customer.address
      @selected_name = current_customer.last_name + current_customer.first_name
    when "registered_address"
      if params[:order][:address_id].present?
        address = Address.find(params[:order][:address_id])
        @selected_postal_code = address.postal_code
        @selected_address = address.address
        @selected_name = address.name
      else
        render :new
      end
    when "new_address"
      unless params[:order][:new_postal_code] == "" && params[:order][:new_address] == "" && params[:order][:new_name] == ""
        @selected_postal_code = params[:order][:new_postal_code]
        @selected_address = params[:order][:new_address]
        @selected_name = params[:order][:new_name]
      else
        render :new
      end
    end
  end

    

  def create
    @order = Order.new(order_params)
    @order.customer_id = current_customer.id
    @order.shipping_cost = 800
    @order.total_payment = current_customer.total_cart_price + @order.shipping_cost
  
    if @order.save
      current_customer.cart_items.each do |cart_item|
        OrderDetail.create!(
          order_id: @order.id,
          item_id: cart_item.item_id,
          price: cart_item.item.with_tax_price,
          amount: cart_item.amount,
        )
      end
  
      current_customer.cart_items.destroy_all
      redirect_to complete_orders_path, notice: "注文が確定しました。"
    else
      flash.now[:alert] = "注文内容にエラーがあります。再度確認してください。"
      rederect_to new_order_path
    end
  end

  def complete
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
