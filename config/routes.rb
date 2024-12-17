Rails.application.routes.draw do
  # Explicit POST route for create_user
  post "dashboard/create_user", to: "dashboard#create_user", as: "create_user"

  # Projects and nested resources
  resources :projects do
    resources :dailies do
      resources :revisions, only: [:create, :update, :destroy]
    end
  end

  # Admin namespace
  namespace :admin do
    get 'dashboard', to: 'dashboard#index'
    resources :users, only: [:create]
  end

  # Devise routes
  devise_for :users, skip: :registrations

  # Root route
  root to: "dashboard#index"
end