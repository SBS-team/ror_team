RorTeam::Application.routes.draw do

  get '/auth/:provider/callback' => 'authentications#create' # For socials networks
  get '/auth/destroy' => 'authentications#destroy'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get 'blog/:created/:id' => 'posts#show', :as => :special_post
  resources :posts, :path => 'blog', only: [:index] do
    resources :comments, only: [:new, :create]
  end
  resources :home, only: [:index]
  resources :team, only: [:index, :show]
  resources :company, only: [:index]
  resources :projects, only: [:index, :show]
  resources :jobs, only: [:index, :show, :create]
  resources :contact, only: [:index, :create]
  resources :live_chats, only: [:new, :create, :show]
  post '/live_chats/chat'
  get '/admin_chat/chat'
  post '/admin_chat/send_msg'

  root :to => 'home#index'
end
