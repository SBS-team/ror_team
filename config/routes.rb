RorTeam::Application.routes.draw do
  get "community/index"
  get "community/show"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  resources :posts
  resources :home
  resources :community
  root :to => "home#index"

end
