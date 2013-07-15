RorTeam::Application.routes.draw do

  get '/auth/:provider/callback' => 'authentications#create' # For socials networks
  get '/auth/destroy' => 'authentications#destroy'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :posts, :path => 'blog', only: [:index, :show] do
    resources :comments, only: [:new, :create]
  end
  get '/blog/:date/:url' => 'posts#show', :as => :my_post
  resources :home, only: [:index]
  resources :team, only: [:index, :show]
  resources :company, only: [:index]
  resources :projects, only: [:index, :show]
  resources :jobs, only: [:index, :show, :create]
  resources :contact, only: [:index, :create]

  root :to => 'home#index'
end
