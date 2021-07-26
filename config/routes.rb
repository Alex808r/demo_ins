Rails.application.routes.draw do
  #root 'application#hello'
  #get 'home/index'

  devise_for :users
  #root to: "home#index"

  resources :users do
    resources :articles
    resources :followers, only: :index
    resources :following, only: :index
  end

  resources :follows, only: :create

  #resources :users, only: [] do
  #resources :articles
  #end

  root to: 'users#index' , as: 'home'
  #root to:  'user_articles_path'


  # Rails.application.routes.draw do
  #   devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  #   }
  # end
end
