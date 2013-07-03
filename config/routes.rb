RorTeam::Application.routes.draw do

  get '/auth/:provider/callback' => 'authentications#create' # For Twitter
  get '/auth/destroy' => 'authentications#destroy'

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :posts do
    resources :comments
  end

  resources :home  #FIXME
  resources :team  #FIXME
  resources :company #FIXME
  resources :work  #FIXME
  resources :jobs  #FIXME
  resources :contact #FIXME
  root :to => 'home#index'

  match 'contact', to: 'contact#new', via: [:get]    #FIXME
  match 'contact', to: 'contact#create', via: [:post]   #FIXME

end
