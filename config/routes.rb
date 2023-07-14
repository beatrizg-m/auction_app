# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :admins
  devise_for :users
  root to: 'home#index'
  resources :items, only: %i[index new create]
  resources :categories, only: %i[new create index]
  resources :batches, only: %i[index new create edit show update destroy] do
    put :approve, on: :member
    put :close, on: :member
    get :search, on: :collection
  end

  post '/place-a-bid', to: 'bids#create'
  get '/finished-batches', to: 'batches#show_finished_batches'
  get '/winning-batches', to: 'batches#winning_batches'
end
