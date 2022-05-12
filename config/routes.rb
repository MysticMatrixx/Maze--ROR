# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'pages#home'

  resources :posts do
    resources :comments
  end

  resource :likes, only: %i[create destroy]

  #VERB     URI PATTERN       CONTROLLER ACT        PREFIX           #
  get 'destroy/:id',  to: 'posts#destroy', as: 'delete_post',   method: :delete
  get 'posts/:id'   ,  to: 'posts#show'   , as: 'show_post'

  # get 'destroy/:id/like', to: 'likes#destroy', as: 'delete_like'
  get 'likes/:id'  ,   to: 'likes#create',  as: 'delete_like', method: :delete

  #     'update/:id'
  # get 'posts/:id' ,  to: 'posts#update' , as: 'update_post', method: :patch
  # not working as expected
end
