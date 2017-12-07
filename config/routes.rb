Rails.application.routes.draw do
  namespace :api do
    resources :users
    resources :logs
    
    # api/auth
    post '/auth', to: "auth#login"
    post '/auth/refresh', to: "auth#refresh"
  end
end
