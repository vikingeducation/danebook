Rails.application.routes.draw do
  root 'users#new'
  get 'timeline', to: 'static_pages#timeline', as: 'timeline'
  get 'friends', to: 'static_pages#friends', as: 'friends'
  get 'about', to: 'static_pages#about', as: 'about'
  get 'photos', to: 'static_pages#photos', as: 'photos'
  get 'about_edit', to: 'static_pages#about_edit', as: 'about_edit'

  resources :users do
    resource :profile, only: [:edit, :update, :show]
  end

  resource :session, :only => [:new, :create, :destroy]
  get 'login' => "users#new"
  delete 'logout' => "sessions#destroy"

end
