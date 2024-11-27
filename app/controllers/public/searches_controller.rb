class Public::SearchesController < ApplicationController
  
  
  def index
    @query = params[:query]
    @items = Item.search_by_name(@query)
  end
end
