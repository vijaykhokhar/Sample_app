Rails.application.routes.draw do
  get 'password_reset/new'
  get 'password_reset/edit'
  get 'sessions/new'
  #get 'users/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  resources :users
  resources :account_activation, only: [:edit]
  resources :password_reset,     only: [:new, :create, :edit, :update]
  #root 'application#hello'# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
