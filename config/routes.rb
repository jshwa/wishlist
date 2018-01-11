Rails.application.routes.draw do

  root to: "lists#index"

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}

  resources :users, only: [:update] do
    resources :reviews, only: [:index]
  end

  get 'users/edit/username', to: 'users#edit', as: 'edit_username'

  resources :lists, only: [:index, :edit, :show, :update]
  resources :categories

  resources :gifts, only: [:index, :show, :new, :create, :update, :destroy] do
    resources :reviews
  end

  namespace :gifts do
    resources :wishlists, only: [:update, :destroy]
  end

end
