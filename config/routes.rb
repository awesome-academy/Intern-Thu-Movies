Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "movies#index"
    get "/movies/:slug", to: "movies#show", as: :movie
  end
end
