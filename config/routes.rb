Rails.application.routes.draw do
  # change to orders#new down the line plz
  root 'orders#index'

  resources :orders
  resources :types, only: %i(index show)

  get '*path', to: 'orders#redirect_to_home'
end
