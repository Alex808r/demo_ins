Rails.application.routes.draw do
  #root 'application#hello'
  #get 'home/index'

  devise_for :users
  root to: "home#index"

  resources :articles

end
