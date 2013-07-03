RorTeam::Application.routes.draw do

  get '/auth/:provider/callback' => 'authentications#create' # For socials networks
  get '/auth/destroy' => 'authentications#destroy'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
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
