Rails.application.routes.draw do
  #root 'application#hello'
  #get 'home/index'

  devise_for :users
  #root to: "home#index"

  #resources :users, only: [] do
       resources :articles
  # end


  root to: 'articles#index', as: 'home'



  # Rails.application.routes.draw do
  #   devise_for :users, controllers: {
  #     sessions: 'users/sessions'
  #   }
  # end
end
