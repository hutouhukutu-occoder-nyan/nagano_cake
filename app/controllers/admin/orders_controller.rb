class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  def show
    @order = Order.find(params[:id])
  end


  def update
    @order = Order.find(params[:id])

    if params[:order][:status] == "入金待ち"
      @order.update(order_params)
      redirect_to admin_order_path(@order) ,notice: '注文ステータスが更新されました。'
      return
    end

    if params[:order][:status] == "入金確認"
      @order.update(order_params)
      @order.order_details.update_all(making_status:1)
      redirect_to admin_order_path(@order) ,notice: '注文ステータスが更新されました。製作ステータスが製作待ちになりました。'
      return
    end

    if params[:order][:status] == "製作中"
      redirect_to admin_order_path(@order) ,alert: 'こちらは手動で変えられません。製作ステータスが更新されるまでお待ちください。'
      return
    end

    if params[:order][:status] == "発送準備中"
      redirect_to admin_order_path(@order) ,alert: 'こちらは手動で変えられません。製作ステータスが全て製作完了になるまでお待ちください'
      return
    end

    if params[:order][:status] == "発送済み"
      if @order.order_details.all? { |order_detail| order_detail.making_status == "製作完了" }
        @order.update(order_params)
        redirect_to admin_order_path(@order) ,notice: '注文ステータスが更新されました。発送済みになりました。'
        return
      else
        redirect_to admin_order_path(@order) ,alert: '製作ステータスが全て製作完了になるまでお待ちください。'
        return
      end
    end

    redirect_to admin_order_path(@order), alert: '注文ステータスの更新に失敗しました。'
    
  end


  private

  def order_params
    params.require(:order).permit(:status)
  end
end
