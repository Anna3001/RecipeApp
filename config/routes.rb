# Rails.application.routes.draw do
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
    # member do
    #   delete 'destroy_image/:image_id', to: 'recipes#destroy_image', as: 'destroy_image'
    # end
    member do
      delete 'destroy_attachment/:attachment_id/:attachment_type', to: 'recipes#destroy_attachment', as: 'destroy_attachment'
    end
  end     
  get 'public_recipes', to: 'recipes#public_recipes', as: 'public_recipes'
  get 'home', to: 'recipes#home', as: 'home'
  root 'recipes#home'
end