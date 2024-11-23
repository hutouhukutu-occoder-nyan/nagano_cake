class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!

  def index
    @orders = Order.order(id: :desc).page(params[:page])
  end
  
end
