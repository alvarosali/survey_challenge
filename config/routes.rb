Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  put '/products', to: 'products#update', defaults: { format: :json }
  get '/products', to: 'products#products', defaults: { format: :json }
  get '/categories', to: 'products#categories', defaults: { format: :json }

  resources :interests, only: :create, defaults: { format: :json }
end
