Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "movies#index"
    get "/movies/:slug", to: "movies#show", as: :movie

    resource :users
    get "/login", to: "sessions#new", as: :login
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    namespace :admin do
      root "dashboard#index"
    end
  end
end
