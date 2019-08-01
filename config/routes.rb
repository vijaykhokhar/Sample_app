Rails.application.routes.draw do
  get 'sessions/new'
  #get 'users/new'
  root 'static_pages#home'
  get '/help', to: 'static_pages#help'
  get '/about', to: 'static_pages#about'
  get '/contact', to: 'static_pages#contact'
  get '/signup', to: 'users#new'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  resources :users
  #root 'application#hello'# For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
