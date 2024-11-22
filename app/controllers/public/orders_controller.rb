class Public::OrdersController < ApplicationController

  # before_action :new_order_check

  def new
    @addresses = current_customer.addresses || []
    if session[:order_address]
      redirect_to check_orders_path(order: {
      address: session[:order_address],
      address_id: session[:order_address_id],
      new_postal_code: session[:order_new_postal_code], 
      new_address: session[:order_new_address],
      new_name: session[:order_new_name] })
    end
  end

  def check
    if request.post?
      # POSTリクエストの場合
      @order = Order.new(order_params)

      if @order.valid?
        # セッションに一時データを保存して次にリダイレクト
        session[:order_data] = @order.attributes
        session[:order_address] = params[:order][:address]
        session[:order_address_id] = params[:order][:address_id]
        session[:order_new_postal_code] = params[:order][:new_postal_code]
        session[:order_new_address] = params[:order][:new_address]
        session[:order_new_name] = params[:order][:new_name]

        # リダイレクトしてGETリクエストに切り替え
        redirect_to public_orders_check_path
      else
        render :new
      end
    else
      # GETリクエストの場合
      # セッションからデータを取得
      @cart_items = CartItem.where(customer_id:current_customer.id)
      @shipping_cost = 800
      @payment_method = Order.payment_methods_i18n[params[:order][:payment_method].to_sym]
      @total_cart_price = current_customer.total_cart_price
      @total_payment = @total_cart_price + @shipping_cost
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
       # セッションをクリア（必要に応じて）
       session.delete(:order_data)
       session.delete(:order_address)
       session.delete(:order_address_id)
       session.delete(:order_new_postal_code)
       session.delete(:order_new_address)
       session.delete(:order_new_name)
    end
  end

  def complete
  end

    

  def create
  end

  def index
  end

  def show
  end

  #private

  #def new_order_check
    #if current_customer.cart_items.empty?
      #redirect_to root_path, alert: "カートが空です。商品を追加してください。"
    #end
  #end

end
