Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root "static_pages#home"

  resources :users do
    resources :posts
  end

  resource :session, only: [:new, :create, :destroy]
  get "/login" => "sessions#create"
  get "/logout" => "sessions#destroy"

  get "/" => "static_pages#home"
  get "/timeline" => "static_pages#timeline"
  get "/friends" => "static_pages#friends"
  get "/about" => "static_pages#about"
  get "/about_edit" => "static_pages#about_edit"
  get "/photos" => "static_pages#photos"

end
