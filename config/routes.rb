Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
  root "movies#index"
  end
end
