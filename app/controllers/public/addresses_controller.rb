class Public::AddressesController < ApplicationController

  def index
    @addresses = Address.all
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path, notice: "新しい配送先が登録されました"
    else
      @addresses = Address.all
      render :index
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def address_params
    params.require(:address).permit(:address, :postal_code, :name)
  end

end
