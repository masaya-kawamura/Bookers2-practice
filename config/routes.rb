Rails.application.routes.draw do

  get 'favorites/create'
  get 'favorites/destroy'
  get 'comments/create'
  get 'comments/destroy'
  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root :to => 'home#top'
  get 'home/about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :books do
    resources :comments,  only: [:create, :destroy]
    resource  :favorites, only: [:create, :destroy]
  end

end
