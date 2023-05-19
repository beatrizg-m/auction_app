Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root to: 'home#index'
  resources :items, only:[:index, :new, :create]
  resources :categories, only:[:new, :create, :index]
  resources :batches, only:[:index, :new, :create, :edit, :show, :update, :destroy] do
    member do
      put :approve
      put :close
    end
  end

  post '/place-a-bid', to: 'bids#create'
  get '/finished-batches', to: 'batches#show_finished_batches'
  get '/winning-batches', to: 'batches#winning_batches'
end
