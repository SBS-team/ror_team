RorTeam::Application.routes.draw do

  get '/auth/:provider/callback' => 'authentications#create' # For Twitter
  get '/auth/destroy' => 'authentications#destroy'

  get 'blog/new'
  get 'careers/new'
  get 'work/new'
  get 'company/new'
  get 'home/new'
  get 'contact/new'

  get 'careers/index'
  get 'work/index'
  get 'company/index'
  get 'home/index'
  get 'contact/index'



  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resource :resume do
    post "careers/create"
  end
  resources :posts do
    resources :comments
  end

  resources :home

  resources :team
  resources :company
  resources :work
  resources :careers
  resources :contact
  root :to => 'home#index'

  match 'contact', to: 'contact#new', via: [:get]
  match 'contact', to: 'contact#create', via: [:post]

end
