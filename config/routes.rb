Rails.application.routes.draw do
  devise_for :users, only: :omniauth_callbacks,
             controllers: {omniauth_callbacks: "users/omniauth_callbacks"}

  scope "(:locale)", locale: /en|vi/ do
    devise_for :users, skip: :omniauth_callbacks, controllers: {
      registrations: "users/registrations",
      sessions: "users/sessions"
    }

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

    namespace :admin do
      root "dashboards#index"
      resources :movies do
        patch "lock", on: :member
      end
    end

    match "*unmatched", to: "application#rescue_404_exception", via: :all
  end
end
