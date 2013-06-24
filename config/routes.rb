RorTeam::Application.routes.draw do
  get "contact/index"
  get "careers/index"
  get "work/index"
  get "company/index"
  get "home/index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resources :posts do
    resources :comments
  end
  resources :home
  root :to => "home#index"

end
