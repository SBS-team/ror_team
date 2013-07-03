RorTeam::Application.routes.draw do

  get '/auth/:provider/callback' => 'authentications#create' # For Twitter
  get '/auth/destroy' => 'authentications#destroy'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :posts, only: [:index, :show] do
    resources :comments, only: [:new, :create]
  end
  resources :home, only: [:index]
  resources :team, only: [:index, :show]
  resources :company, only: [:index]
  resources :work, only: [:index, :show]
  resources :jobs, only: [:index, :show, :create]
  resources :contact, only: [:index, :new, :create]

  root :to => 'home#index'


end
