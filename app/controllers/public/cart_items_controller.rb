class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  
  def create
    cart_item = CartItem.new(cart_item_params)
    cart_item.customer_id = current_customer.id
    cart_item.item_id = cart_item_params[:item_id]
    if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
      cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
      cart_item.amount += params[:cart_item][:amount].to_i
      cart_item.update(amount:cart_item.amount)
      redirect_to cart_items_path
    else
      cart_item.save
      redirect_to cart_items_path
    end
  end

  def index
    @cart_items = current_customer.cart_items
    @sum = current_customer.total_cart_price
  end

  def update
    cart_item = CartItem.find(params[:id])
    if cart_item.update(cart_item_params)
      redirect_to request.referer,notice:'数量を変更しました'
    else
      redirect_to request.referer,alart:'数量の変更に失敗しました'
    end
  end

  def all_destroy
    cart_items = current_customer.cart_items
    cart_items.all_destroy
    redirect_to request.referer
  end
  
  def destroy
    cart_item = CartItem.find(params[:id])
    if cart_item.destroy
      redirect_to request.referer,notice:'商品を削除しました'
    else
      redirect_to request.referer,alart:'商品の削除に失敗しました'
    end
  end

  def destroy_all
    cart_items = current_customer.cart_items
    if cart_items.destroy_all
      redirect_to request.referer,notice:'商品を全て削除しました'
    else
      redirect_to request.referer,alart:'商品の全削除に失敗しました'
    end
  end

  private

  def cart_item_params
    params.require(:cart_item).permit(:customer_id, :item_id, :amount)
  end

end
