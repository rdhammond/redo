Rails.application.routes.draw do
  devise_for :users
  resources :tasks, only: [:index, :new, :show, :create, :update, :destroy]
  get 'home/index'
  root 'home#index'
end
