Rails.application.routes.draw do

#会員

  # 会員側トップ,アパウトページ
  root to: 'public/homes#top'
  get '/about', to: 'public/homes#about'

  #orders,cart_items,items,adressees
  scope module: :public do
    resources :orders, only: [:new, :create, :index, :show]
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :items, only: [:index, :show]
    resources :adresses, only: [:index, :create, :edit, :update, :destroy]
  end
  post '/orders/check', to: 'public/orders#check', as: :public_orders_check
  get '/orders/complete', to: 'public/orders#complete', as: :public_orders_complete
  delete '/cart_items/all_destroy', to: 'public/cart_items#all_destroy', as: :cart_items_all_destroy

  #customer
  get '/customers/my_page', to: 'public/customers#show', as: 'customer'
  get '/customers/information/edit', to: 'public/customers#edit', as: 'edit_customer'
  patch '/customers/information', to: 'public/customers#update', as: 'update_customer'
  get '/customers/unsubscribe', to: 'public/customers#unsubscribe', as: 'unsubscribe_customer'
  patch '/customers/withdraw', to: 'public/customers#withdraw', as: 'withdraw_customer'


#管理者

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]
  end


#device

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }


  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
