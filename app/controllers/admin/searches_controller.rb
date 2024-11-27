class Admin::SearchesController < ApplicationController
  before_action :authenticate_admin!
  def index
    @query = params[:query]
    @items = Item.search_by_name(@query)
  end
end
