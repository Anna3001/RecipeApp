# Rails.application.routes.draw do
#   get "ingredients/index"
#   get "ingredients/show"
#   get "ingredients/new"
#   get "ingredients/create"
#   get "ingredients/edit"
#   get "ingredients/update"
#   get "ingredients/destroy"
#   get "recipes/index"
#   get "recipes/show"
#   get "recipes/new"
#   get "recipes/create"
#   get "recipes/edit"
#   get "recipes/update"
#   get "recipes/destroy"
#   devise_for :users
#   # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

#   # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
#   # Can be used by load balancers and uptime monitors to verify that the app is live.
#   get "up" => "rails/health#show", as: :rails_health_check

#   # Render dynamic PWA files from app/views/pwa/*
#   get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
#   get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

#   # Defines the root path route ("/")
#   # root "posts#index"
# end

Rails.application.routes.draw do
  devise_for :users
  resources :recipes do
    resources :ingredients
  end
  root 'recipes#index'
end