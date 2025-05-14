Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker", to: "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest",       to: "rails/pwa#manifest",       as: :pwa_manifest

  root "posts#index"

  get "posts/:year/:month/:day/:id", to: "posts#show"

  resource :session
  resources :passwords, param: :token

  resources :posts, only: :index
  resources :tags, only: :show, param: :name

  namespace :admin do
    root "posts#index"

    resources :posts, only: %i[new create edit update destroy] do
      get "preview", on: :collection
    end
  end

  direct :post do |post|
    year, month, day = post.created_at.to_date.to_s.split("-")

    {
      controller: "/posts",
      action: :show,
      year:,
      month:,
      day:,
      id:     post.id
    }
  end
end
