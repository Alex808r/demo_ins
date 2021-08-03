Rails.application.routes.draw do
  #root 'application#hello'
  #get 'home/index'

  resources :articles do
    resources :likes
  end

  resources :articles do
    resources :comments
  end

  devise_for :users

  resources :users do
    resources :articles
    resources :followers, only: :index
    resources :following, only: :index
  end

  resources :follows, only: [:create, :destroy] # или так "resources :follows, only: %i[create, destroy]"

  resources :feed_articles, only: :index

  root to: 'users#index' , as: 'home'

  #root to: 'feed_articles#index' , as: 'home'
  #root to:  'user_articles_path'
  #root to: "home#index"

  # Rails.application.routes.draw do
  #   devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  #   }
  # end
end
