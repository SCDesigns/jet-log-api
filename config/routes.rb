Rails.application.routes.draw do
  namespace :api do
    resources :users, only: [:create]
    resources :logs
    resources :locations
    resources :continents

    post '/auth', to: "auth#login"
    post '/auth/refresh', to: "auth#refresh"
  end
end
