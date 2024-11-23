Rails.application.routes.draw do
  get "admin/index"
  root "admin#dashbord"
  resource :session
  resources :passwords, param: :token
  get "up" => "rails/health#show", as: :rails_health_check
end
