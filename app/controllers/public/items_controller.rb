class Public::ItemsController < ApplicationController

  def index
    @items = Item.where(is_active: true).page(params[:page]).per(8)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item_new = CartItem.new
    @genres = Genre.all
  end

end
