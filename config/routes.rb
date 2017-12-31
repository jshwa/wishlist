Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: "wishlists#index"
  resources :gifts, only: [:index, :new, :edit, :show]
  resources :wishlists, only: [:index, :new, :edit, :show]
  resources :categories, only: [:index, :new, :edit, :show]

end
