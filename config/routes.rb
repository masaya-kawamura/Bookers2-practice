Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root :to => 'home#top'
  get 'home/about'

  resources :users, only: [:index, :show, :edit, :update] do
    member do  #GET users/1/following
      get :following, :followers
    end

  end

  resources :books do
    resources :comments,  only: [:create, :destroy]
    resource  :favorites, only: [:create, :destroy]
  end
  
resources :relationships, only: [:create, :destroy]

end
