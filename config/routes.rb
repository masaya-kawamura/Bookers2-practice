Rails.application.routes.draw do

  devise_for :users, controllers: {
    registrations: "users/registrations"
  }

  root :to => 'home#top'
  get 'home/about'
  resources :users, only: [:index, :show, :edit, :update]
  resources :books

end
