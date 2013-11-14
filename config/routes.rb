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

  post '/create_chat' => 'live_chats#create_chat', as: :user_start_chat
  post '/chat_send_msg' => 'live_chats#send_msg', as: :user_chat
  post '/new_chat' => 'live_chats#new_chat'
  post '/chat_close' => 'live_chats#chat_close'

  post '/pusher/auth'
  post '/admin_chat/send_msg'
  post '/admin_chat/close'

  get 'projects/:id' => 'projects#show', as: :project_load

  root to: 'home#index'

end
