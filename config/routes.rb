Rails.application.routes.draw do
  resources :tasks
  get 'home/index'
  root 'home#index'
end
