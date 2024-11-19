Rails.application.routes.draw do
  get 'homes/top'
  get 'homes/about'
  
  #cart_items
  delete '/cart_items/all_destroy', to: 'public/cart_items#all_destroy', as: :cart_items_all_destroy
  scope module: :public do
    resources :cart_items, only: [:index, :update, :destroy, :create]
  end 


  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  namespace :admin do
    resources :customers, only: [:index, :show, :edit, :update]
  end

  get '/customers/my_page', to: 'public/customers#show', as: 'customer'
  get '/customers/information/edit', to: 'public/customers#edit', as: 'edit_customer'
  patch '/customers/information', to: 'public/customers#update', as: 'update_customer'
  get '/customers/unsubscribe', to: 'public/customers#unsubscribe', as: 'unsubscribe_customer'
  patch '/customers/withdraw', to: 'public/customers#withdraw', as: 'withdraw_customer'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
