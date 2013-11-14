RorTeam::Application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  mount Ckeditor::Engine => '/ckeditor'

  resources :posts, path: 'blog', only: [:index] do
    resources :comments, only: [:new, :create]
  end
  resources :home, only: [:index, :create]
  resources :team, only: [:index, :show]
  resources :company, only: [:index]
  resources :projects, only: [:index]
  resources :jobs, only: [:index, :show, :create]
  resources :contact, only: [:index, :create]
  resources :resume, only: [:new, :create, :show]

  get 'blog/:created/:id' => 'posts#show', as: :special_post
  get 'blog/archives/:month/:year' => 'posts#archives', as: :archives
  post '/blog/comments' => 'comments#create'
  get '/admin_chat/chat', as: :admin_start_chat
  post '/admin_chat/go_offline', as: :admin_go_offline

  post '/admin/time_online' => 'time_onlines#set_time'
  post '/comment_load' => 'posts#comments_show_all'

  #=============================================== User chat =================
  post 'chat/new' => 'live_chats#new'
  post 'chat/create' => 'live_chats#create', as: :user_chat_create
  post 'chat/close' => 'live_chats#close'
  post 'chat/send' => 'live_chats#msg_send', as: :user_chat
  #===========================================================================


  post '/pusher/auth'
  post '/admin_chat/send_msg'
  post '/admin_chat/close'

  get 'projects/:id' => 'projects#show', as: :project_load
  #get 'send_resume' => 'resume#new', as: :send_resume

  root to: 'home#index'

end
