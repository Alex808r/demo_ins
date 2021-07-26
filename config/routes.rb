Rails.application.routes.draw do
  #root 'application#hello'
  #get 'home/index'

  devise_for :users
  #root to: "home#index"

  resources :users do
    resources :followers, only: :index
    resources :following, only: :index
  end

  resources :follows, only: :create
  #resources :follows, only: :create
  #resources :users, only: [] do
       resources :articles
  #end


  root to: 'articles#index', as: 'home'



  # Rails.application.routes.draw do
  #   devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  #   }
  # end
end
