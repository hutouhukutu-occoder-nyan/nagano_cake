class Public::ItemsController < ApplicationController

  def index
  end

  def show
    @item = Item.find(params[:id])
    @cart_item_new = CartItem.new
  end

end
