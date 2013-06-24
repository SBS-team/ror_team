RorTeam::Application.routes.draw do
  get "blog/index"
  get "contact/index"
  get "careers/index"
  get "work/index"
  get "company/index"
  get "home/index"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users
  resources :posts
  resources :home
  root :to => "home#index"

end
