Rails.application.routes.draw do

  root 'home#top'
  namespace :admin do
    resources :products, only: [:index, :new, :create, :show, :edit, :update]
  end
  namespace :admin do
    resources :orders, only: [:index, :update, :show]
  end
  namespace :admin do
    root 'home#top'
  end
  namespace :admin do
    resources :genres, only: [:index, :create, :edit, :update]
  end
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
  end
  get 'home/about'
  get 'orders/confirm'
  get 'orders/thanks'
  get 'users/confirm'
  devise_for :admins
  devise_for :users

  resources :orders, only: [:new, :create, :index, :show]
  resources :products, only: [:index, :show]
  resources :users, only: [:edit, :update, :show] do
    resources :cart_products, only: [:index, :update, :create, :destroy]
    get 'cart_products/destroy_all'
    resources :receivers, only: [:index, :create, :destroy, :edit, :update]
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
