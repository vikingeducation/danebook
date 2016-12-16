Rails.application.routes.draw do
  root :to => 'users#new'

  resources :users, only: [:new, :create, :show, :index] do
    get 'about', on: :member
    get 'timeline', on: :member
    get 'friends', on: :member
    get 'photos', on: :member
    get 'newsfeed', on: :member
  end

  resources :friendships, only: [:create, :destroy]
  resources :profiles, only: [:edit, :update]

  resources :posts, only: [:create, :update, :destroy] do
    get 'like', on: :member
    get 'unlike', on: :member
    resources :comments, only: [:create, :destroy] do
      get 'like', on: :member
      get 'unlike', on: :member
    end
  end

  resources :photos, only: [:new, :create, :show, :destroy] do
    get 'like', on: :member
    get 'unlike', on: :member
    get 'profile', on: :member
    get 'cover', on: :member
    resources :comments, only: [:create, :destroy] do
      get 'like', on: :member
      get 'unlike', on: :member
    end
    post 'create_with_url', on: :collection
  end

  resource :session, only: [:create, :destroy]
  delete "logout" => "sessions#destroy"
  get 'auth/:provider/callback', to:'users#create'
end
