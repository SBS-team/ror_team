RorTeam::Application.routes.draw do
  #get "careers/create"
  get "contact/index"
  get "careers/index"
  get "work/index"
  get "company/index"
  get "home/index"

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  resource :resume do
    post "careers/create"
  end
  resources :posts do
    resources :comments
  end
  #resources :home
  #resources :users do
  #  resources :resumes
  #end

  root :to => "home#index"

end
