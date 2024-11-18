Rails.application.routes.draw do

  #orders
  scope module: :public do
    resources :orders, only: [:new, :create, :index, :show]
  end
  post '/orders/check', to: 'public/orders#check', as: :public_orders_check
  get '/orders/complete', to: 'public/orders#complete', as: :public_orders_complete
  

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }

  devise_for :customers, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
