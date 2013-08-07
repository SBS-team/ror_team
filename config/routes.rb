RorTeam::Application.routes.draw do

  post '/comment_load' => 'posts#comments_show_all'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  post '/admin/time_online' => 'time_onlines#set_time'

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
  post '/contact/create_chat'
  post '/contact/chat'

  post '/application/create_chat', :as => :user_start_chat
  post '/application/chat', :as => :user_chat
  post '/chat_close' => 'application#chat_close'

  resources :live_chats, only: [:new, :create, :show]
  post '/live_chats/chat'
  post '/pusher/auth'
  get '/admin_chat/chat', :as => :admin_start_chat
  post '/admin_chat/send_msg'
  post '/admin_chat/close'

  root :to => 'home#index'
end
