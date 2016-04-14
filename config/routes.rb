Rails.application.routes.draw do

  root 'users#new'

  get 'newsfeed' => 'activities#index'

  resources :activities, only: [:index]


  resource :session, only: [:new, :create, :destroy]
  get 'login' => 'users#new'
  delete 'logout' => 'sessions#destroy'


  resources :users do

    resources :friendings, only: [:index, :create, :destroy]

    resource :profile, only: [:edit, :update, :show]

    resources :posts, only: [:index, :create, :destroy] do
      resources :likes, only: [:create, :destroy], defaults: { :likeable => 'Post'}
    end

    resources :comments, only: [:create, :destroy] do
      resources :likes, only: [:create, :destroy], defaults: { :likeable => 'Comment'}
    end

    resources :photos, only: [:show, :new, :create, :index, :destroy] do
      resources :likes, only: [:create, :destroy], defaults: { :likeable => 'Photo'}
    end

    get 'timeline' => 'posts#index'
  end




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
