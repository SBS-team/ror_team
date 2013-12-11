RorTeam::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'

  resources :posts, path: 'news', only: [:index] do
    resources :comments, only: [:new, :create]
  end
  resources :home, only: [:index, :create]
  resources :team, only: [:index, :show]
  resources :company, only: [:index]
  resources :projects, only: [:index]
  resources :jobs, only: [:index, :show, :create]
  resources :contact, only: [:index, :create]
  resources :resume, only: [:new, :create, :show]

  get 'news/:created/:id' => 'posts#show', as: :special_post
  get 'news/archives/:month/:year' => 'posts#archives', as: :archives
  post '/news/comments' => 'comments#create'

  post '/admin/time_online' => 'time_onlines#set_time'
  post '/comment_load' => 'posts#comments_show_all'

  #=============================================== User chat =================
  post 'chat/new' => 'live_chats#new'
  post 'chat/create' => 'live_chats#create', as: :user_chat_create
  post 'chat/close' => 'live_chats#close'
  post 'chat/send' => 'live_chats#msg_send', as: :user_chat
  #=============================================== Admin chat ================
  post '/pusher/auth'
  post '/admin_chat/send_msg'
  post '/admin_chat/close'
  post '/admin_chat/go_offline', as: :admin_go_offline
  #===========================================================================

  get 'projects/:id' => 'projects#show', as: :project_load

  root to: 'home#index'

end
