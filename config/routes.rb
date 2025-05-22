Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest",       to: "rails/pwa#manifest",       as: :pwa_manifest

  root "posts#index"

  resource :session
  resources :passwords, param: :token
  resources :posts, only: :show
  resources :tags, only: :show, param: :name
  resource :feed, only: :show

  namespace :admin do
    root "posts#index"

    resources :posts, only: %i[new create edit update destroy] do
      get "preview", on: :collection
    end

    mount Litestream::Engine, at: "/litestream"
  end

  get "posts.atom", to: redirect("feed.atom")
end
