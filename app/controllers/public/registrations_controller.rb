# frozen_string_literal: true

class Public::RegistrationsController < Devise::RegistrationsController
  before_action :configure_sign_up_params, only: [:create]
  before_action :configure_account_update_params, only: [:update]

  def after_sign_up_path_for(resource)
    customer_path
  end

  def create
    # サインアップに使用した全カラムで検索
    @user = Customer.find_by(
      email: params[:customer][:email],
      last_name: params[:customer][:last_name],
      first_name: params[:customer][:first_name],
      last_name_kana: params[:customer][:last_name_kana],
      first_name_kana: params[:customer][:first_name_kana],
      postal_code: params[:customer][:postal_code],
      address: params[:customer][:address],
      telephone_number: params[:customer][:telephone_number]
    )
  
    # 退会済みユーザーの再アクティブ化処理
    if @user&.is_active == false
      @user.update(is_active: true) # Reactivateメソッドがない場合、直接更新
      flash[:notice] = '再入会が完了しました'
      redirect_to root_path and return # 必要なリダイレクト先を指定
    end
  
    # 通常のDeviseサインアップ処理
    super
  end

  # GET /resource/sign_up
  # def new
  #   super
  # end

  # POST /resource
  # def create
  #   super
  # end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_active])
  end

  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: [:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :telephone_number, :is_active])
  end


end
