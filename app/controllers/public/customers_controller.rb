class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!
  
  def show
    @user = current_customer
  end

  def edit
    @user = current_customer
  end

  def update
    @user = current_customer
    @user.update(customer_params)
    redirect_to customer_path(@user)
  end

  def unsubscribe
    @user = current_customer
  end

  def withdraw
    @user = current_customer
    @user.update(is_active: false)
    reset_session
    redirect_to root_path
  end
end
