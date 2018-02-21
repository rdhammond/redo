Rails.application.routes.draw do
  resources :tasks, only: [:index, :show, :update, :destroy, :create]
  get 'home/index'
  root 'home#index'
end
