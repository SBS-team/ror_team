RorTeam::Application.routes.draw do

  get 'blog/new'
  get 'jobs/new'
  get 'work/new'
  get 'company/new'
  get 'home/new'

  get 'jobs/index'
  get 'work/index'
  get 'company/index'
  get 'home/index'


  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resource :resume do
    post "jobs/create"
  end
  resources :posts do
    resources :comments
  end

  resources :home

  resources :team
  resources :company
  resources :work
  resources :jobs
  resources :contact
  root :to => 'home#index'

  match 'contact', to: 'contact#new', via: [:get]
  match 'contact', to: 'contact#create', via: [:post]

end
