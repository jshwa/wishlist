Rails.application.routes.draw do

  devise_for :users, controllers: {omniauth_callbacks: 'users/omniauth_callbacks'}
  resources :users, only: [:update]
  get 'users/edit_username', to: 'users#edit_username', as: 'edit_username'
  root to: "lists#index"
  resources :lists, only: [:index, :edit, :show]
  resources :categories
  resources :gifts, only: [:index, :show, :new, :create, :update, :destroy] do
    resources :reviews
  end
end
