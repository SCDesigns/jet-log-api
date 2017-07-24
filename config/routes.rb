Rails.application.routes.draw do
  namespace :api do
    resources :users
    resources :logs
    resources :locations
    resources :continents
  end
end
