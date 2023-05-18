Rails.application.routes.draw do
  devise_for :admins

  root to: 'home#index'
  resources :items, only:[:index, :new, :create]
  resources :categories, only:[:new, :create, :index]
  resources :batches, only:[:index, :new, :create, :edit, :show, :update] do
    member do
      put :approve
    end
  end
end
