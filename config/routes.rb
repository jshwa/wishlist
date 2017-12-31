Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: "lists#index"
  resources :gifts
  resources :lists, only: [:index, :edit, :show]
  resources :categories

end
