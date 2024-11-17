Rails.application.routes.draw do
  
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
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
