Rails.application.routes.draw do
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
  get '/customers/unsubscribe', to: 'public/customers#unsubscribe', as: 'unsbscribe_customer'
  patch '/customers/withdrow', to: 'public/customers#withdrow', as: 'withdrow_customer'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
