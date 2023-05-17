Rails.application.routes.draw do
  devise_for :admins

  root to: 'home#index'
  resources :items, only:[:index, :new, :create]
  resources :categories, only:[:new, :create, :index]
end
