RorTeam::Application.routes.draw do
  get 'contact/index'
  get 'careers/index'
  get 'work/index'
  get 'company/index'
  get 'home/index'

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
  resources :careers
  resources :contact
  root :to => "home#index"

end
