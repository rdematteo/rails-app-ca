Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :providers, path: 'providers'
  devise_for :users, path: 'users'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  resources :listings
  resources :providers
  resources :users
end
