class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!
  
  def update
    order_detail = OrderDetail.find(params[:id])
    order = order_detail.order

    if params[:order_detail][:making_status] == "着手不可" 
      redirect_to request.referer,alert: 'こちらは手動で変えられません。'
      return
    end

    if params[:order_detail][:making_status] == "製作待ち" 
      redirect_to request.referer,alert: 'こちらは手動で変えられません。'
      return
    end
    
    if order_detail.update(order_detail_params)

      if params[:order_detail][:making_status] == "製作中" 
        if order.status == "製作中"
          redirect_to request.referer,notice: '製作ステータスが製作中に更新されました。'
        else
          order.update(status: 2)
          order.reload
          redirect_to request.referer,notice: '製作ステータスが製作中に更新されました。注文ステータスが製作中になりました。'
        end
      end

      if params[:order_detail][:making_status] == "製作完了"
        if is_all_order_details_making_completed(order)
          order_detail.order.update(status:3)
          redirect_to request.referer,notice: '製作ステータスは、全て製作完了になりました。注文ステータスが発送準備中になりました。'
        else
          redirect_to request.referer,notice: '製作が製作完了に更新されましたが、すべての製作は完了しておりません。'
        end
      end
    else
      redirect_to request.referer,alert: '製作ステータスの更新に失敗しました。'
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:making_status)
  end

  def is_all_order_details_making_completed(order)
    #order.order_details.each do |order_detail|
      #order_detail.making_status != "製作完了"
      unless order.order_details.all? { |order_detail| order_detail.making_status == "製作完了" }
        return false 
      end
    return true 
  end  

end
