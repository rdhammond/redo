Rails.application.routes.draw do
  resources :tasks, only: [:index, :new, :show, :create, :update, :destroy]
  get 'home/index'
  root 'home#index'
end
