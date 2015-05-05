Rails.application.routes.draw do

  # OAUTH ROUTES
  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')



  get '/newsfeed' => 'newsfeed#index'

  resources :users, except: [:edit] do

    resource :profile, only: [:edit, :update, :show]


    get '/friend_requests' => 'friend_requests#index'
    resource :friend_requests, only: [ :index, :create, :destroy ]


    get '/friends' => 'friendings#index'
    resource :friendings, only: [ :index, :create, :destroy ]
    resource :friend_requests, only: [ :index, :create, :destroy ]



    resources :photos do
      resources :likes, only: [:create, :destroy], :defaults => { :likable => 'Photo' }

      resources :comments, only: [:create, :destroy], :defaults => { :commentable => 'Photo' } do
        resources :likes, only: [:create, :destroy], :defaults => { :likable => 'Comment'}
      end
    end



    resources :posts do
      resources :likes, only: [:create, :destroy], :defaults => { :likable => 'Post' }

      resources :comments, only: [:create, :destroy], :defaults => { :commentable => 'Post' } do
        resources :likes, only: [:create, :destroy], :defaults => { :likable => 'Comment'}
      end
    end

    # user post timeline index
    get '/timeline' => 'posts#index'
  end



  # LOGIN AND LOGOUT

  resource :session, only: [:new, :create, :destroy]

  root 'users#new'
  get '/login' => 'users#new'
  delete '/logout' => 'sessions#destroy'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
