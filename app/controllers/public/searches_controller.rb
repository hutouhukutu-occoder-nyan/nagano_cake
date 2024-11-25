class Public::SearchesController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @query = params[:query]
    @items = Item.search_by_name(@query)
  end
end
