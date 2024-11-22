class Admin::CustomersController < ApplicationController
  def index
    @users = Customer.page(params[:page])
  end

  def show
    @user = Customer.find(params[:id])
  end

  def edit
    @user = Customer.find(params[:id])

  end

  def update
    @user = Customer.find(params[:id])
    @user.update(customer_params)
    redirect_to admin_customer_path(@user)
  end

end
