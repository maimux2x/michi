Rails.application.routes.draw do
  root "posts#index"

  resource :session
  resources :passwords, param: :token
  get "up" => "rails/health#show", as: :rails_health_check

  resources :posts, only: %i[index show]

  namespace :admin do
    root "posts#index"

    resources :posts, only: %i[new create edit update destroy]
  end
end
