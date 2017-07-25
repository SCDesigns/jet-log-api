Rails.application.routes.draw do
  namespace :api do
    resources :users
    resources :logs
    resources :locations
    resources :continents

    post '/auth', to: "auth#login"
  end
end
