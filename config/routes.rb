RorTeam::Application.routes.draw do
  get "blog/new"
  get "contact/new"
  get "careers/new"
  get "work/new"
  get "company/new"
  get "home/new"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  resources :posts
  resources :home
  root :to => "home#new"

end
