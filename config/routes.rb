Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  # categories
  resources :categories

  # items
  resources :items

  # users cna sign up multiple times
  resources :users

  # users can only make one session
  resource :session

  get "about", to: "pages#about"
  root "pages#home"

end
