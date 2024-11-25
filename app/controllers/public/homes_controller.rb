class Public::HomesController < ApplicationController
  def top
    @genres = Genre.all
    @item_latest4 = Item.last(4)
  end

  def about
  end
  
end
