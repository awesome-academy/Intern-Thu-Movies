Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "movies#index"
    get "/movies/:slug", to: "movies#show", as: :movie
    get "/movies/watch/:slug", to: "movies#watch", as: :watch

    resources :search, only: :index

    resources :favoriate_movies, :bookmark_movies, only: %i(index create destroy)

    resources :rates, only: %i(create destroy)

    resources :movies do
      resources :comments, only: %i(create destroy)
    end
    resources :comments do
      resources :comments, only: %i(create destroy)
    end

    resource :users
    get "/login", to: "sessions#new", as: :login
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"

    namespace :admin do
      root "dashboards#index"
      resources :movies do
        patch "lock", on: :member
      end
    end

    match "*unmatched", to: "application#rescue_404_exception", via: :all
  end
end
