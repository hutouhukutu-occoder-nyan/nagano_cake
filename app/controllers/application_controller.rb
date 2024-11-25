class ApplicationController < ActionController::Base

  def after_sign_in_path_for(resource)
    case resource
    when Admin
      admin_path
    when Customer
      root_path
    else
      root_path
    end
  end

  def after_sign_up_path_for(resource)
      customer_path
  end

  def after_sign_out_path_for(resource)
    case resource
    when Admin
      new_admin_session
    when Customer
      root_path
    else
      root_path
    end
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :postal_code, :address, :telephone_number, :email, :is_active)
  end
end
