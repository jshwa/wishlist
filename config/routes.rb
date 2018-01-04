Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  root to: "lists#index"
  resources :lists, only: [:index, :edit, :show]
  resources :categories
  resources :gifts, only: [:index, :show, :new, :create, :update, :destroy] do
    resources :reviews
  end
end
