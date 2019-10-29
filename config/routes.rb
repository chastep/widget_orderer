Rails.application.routes.draw do
  # change to orders#new down the line plz
  root 'orders#index'

  resources :orders do
    member do
      put 'ship'
      put 'complete'
    end
  end
  resources :types, only: %i(index show)

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'

  get '*path', to: 'orders#redirect_to_home'
end
