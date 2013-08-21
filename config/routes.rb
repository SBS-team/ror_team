RorTeam::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'

  resources :posts, path: 'blog', only: [:index] do
    resources :comments, only: [:new, :create]
  end
  resources :home, only: [:index]
  resources :team, only: [:index, :show]
  resources :company, only: [:index]
  resources :projects, only: [:index, :show]
  resources :jobs, only: [:index, :show, :create]
  resources :contact, only: [:index, :create]

  get 'blog/:created/:id' => 'posts#show', as: :special_post
  get '/admin_chat/chat', as: :admin_start_chat

  post '/admin/time_online' => 'time_onlines#set_time'
  post '/comment_load' => 'posts#comments_show_all'
  post '/contact/create_chat'
  post '/contact/chat'
  post '/create_chat' => 'live_chats#create_chat', as: :user_start_chat
  post '/chat_send_msg' => 'live_chats#send_msg', as: :user_chat
  post '/new_chat' => 'live_chats#new_chat'
  post '/chat_close' => 'live_chats#chat_close'
  post '/live_chats/chat'
  post '/pusher/auth'
  post '/admin_chat/send_msg'
  post '/admin_chat/close'

  root to: 'home#index'

end
