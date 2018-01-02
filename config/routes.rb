Rails.application.routes.draw do

  resources :users

  resource :session
  
  get "about", to: "pages#about"
  root "pages#home"

end
