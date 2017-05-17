Rails.application.routes.draw do

  root 'users#new'

  get 'login' => 'users#new'
  delete 'logout' => 'sessions#destroy'
  get 'newsfeed' => 'newsfeeds#index'

  resources :users, :only => [:new, 
                              :create, 
                              :edit, 
                              :update] do

    resources :posts, :only => [:create, :destroy]
    get '/timeline' => 'posts#index'
    resources :friends, :only => [:create, 
                                  :destroy,
                                  :index]
    resources :photos, :only => [:index, :show]
  end

  get '/users/:id/about',
    to: 'users#about',
    as: 'about_user'
  
  resource :session, :only => [:new, :create, :destroy]
  resources :friend_requests, only: [:index]
  resources :comments, :likes, :only => [:create, :destroy]
  resources :photos, :only => [:new, :create, :destroy, :update]

end
